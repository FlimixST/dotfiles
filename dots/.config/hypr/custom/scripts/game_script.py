#!/usr/bin/env python3
import json
import os
import socket
import time

CONFIG_PATH = os.path.expanduser("~/.config/illogical-impulse/config.json")
EVENT_SOCK = ".socket2.sock"
CMD_SOCK = ".socket.sock"

current_mode = "reset"
current_class = ""
games = []
mtime = 0.0


def load_games():
    try:
        with open(CONFIG_PATH) as f:
            gm = json.load(f).get("gamemode", {})
    except (OSError, json.JSONDecodeError):
        return []
    if not gm.get("enable", True):
        return []
    return [g.lower() for g in gm.get("games", []) if g]


def refresh():
    global mtime
    try:
        m = os.stat(CONFIG_PATH).st_mtime
    except OSError:
        return
    if m == mtime:
        return
    mtime = m
    games[:] = load_games()


def connect(name, timeout=None):
    runtime = os.getenv("XDG_RUNTIME_DIR", f"/run/user/{os.getuid()}")
    sig = os.getenv("HYPRLAND_INSTANCE_SIGNATURE")
    if not sig:
        return None
    path = os.path.join(runtime, "hypr", sig, name)
    try:
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        if timeout:
            sock.settimeout(timeout)
        sock.connect(path)
        return sock
    except OSError:
        return None


def set_mode(mode):
    global current_mode
    if mode == current_mode:
        return
    sock = connect(CMD_SOCK, timeout=1)
    if sock is None:
        return
    try:
        sock.sendall(f'dispatch hl.dsp.submap("{mode}")\n'.encode())
    except OSError:
        return
    finally:
        sock.close()
    current_mode = mode


def update_mode():
    set_mode("gamemode" if current_class in games else "reset")


def on_activewindow(event):
    global current_class
    _, _, data = event.partition(">>")
    current_class = data.split(",")[0].lower()
    refresh()
    update_mode()


def on_focus_lost():
    global current_class
    current_class = ""
    update_mode()


games[:] = load_games()
refresh()

while True:
    sock = connect(EVENT_SOCK)
    if sock is None:
        time.sleep(2)
        continue
    try:
        sock.sendall(b"[[STREAM]]\n")
        buffer = ""
        while True:
            data = sock.recv(4096).decode("utf-8", errors="ignore")
            if not data:
                break
            buffer += data
            lines = buffer.split("\n")
            buffer = lines[-1]
            for line in lines[:-1]:
                name = line.partition(">>")[0]
                if name == "activewindow":
                    on_activewindow(line)
                elif name in ("workspace", "focusedmon"):
                    on_focus_lost()
    except OSError:
        time.sleep(2)
    finally:
        sock.close()
#!/usr/bin/env python3
import socket
import json
import os
import sys
import subprocess
import time

CONFIG_PATH = os.path.expanduser("~/.config/illogical-impulse/config.json")
LOCK_FILE = "/tmp/game_manual_lock"
current_mode = "global"
last_class = ""

def load_config():
    try:
        with open(CONFIG_PATH) as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        return {"gamemode": {"enable": True, "games": []}}

def get_games():
    config = load_config()
    gm = config.get("gamemode", {})
    if not gm.get("enable", True):
        return []
    return [g.lower() for g in gm.get("games", []) if g]

def get_socket_path():
    sig = os.getenv("HYPRLAND_INSTANCE_SIGNATURE")
    if sig:
        base_path = f"/run/user/1000/hypr/{sig}"
        for sock_name in [".socket2.sock", ".socket.sock", ".hyprland.sock.1"]:
            path = f"{base_path}/{sock_name}"
            if os.path.exists(path):
                return path
    return os.path.expanduser("~/.hyprland/.hyprland.sock.1")

def get_active_window():
    try:
        out = subprocess.check_output(["/usr/bin/hyprctl", "activewindow", "-j"], timeout=0.5)
        return json.loads(out)
    except:
        return {}

def set_mode(mode):
    global current_mode
    if mode == current_mode:
        return
    try:
        subprocess.run(["/usr/bin/hyprctl", "dispatch", f'hl.dsp.submap("{mode}")'], 
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=1)
        current_mode = mode
    except:
        pass

def check_and_update_mode():
    global last_class
    
    try:
        win = get_active_window()
        if not win:
            return
        
        class_name = win.get("class", "").lower()
        
        if class_name == last_class:
            return
        
        last_class = class_name
        games = get_games()
        
        if os.path.exists(LOCK_FILE):
            target = "reset"
        elif any(g in class_name for g in games):
            target = "gamemode"
        else:
            target = "reset"
        
        set_mode(target)
    except:
        pass

check_and_update_mode()

while True:
    try:
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        sock.settimeout(5)
        sock.connect(get_socket_path())
        sock.send(b"[[STREAM]]\n")
        
        buffer = ""
        while True:
            try:
                data = sock.recv(4096).decode('utf-8', errors='ignore')
                if not data:
                    break
                
                buffer += data
                lines = buffer.split('\n')
                buffer = lines[-1]
                
                for line in lines[:-1]:
                    if "activewindow" in line or "windowtitle" in line:
                        check_and_update_mode()
            except socket.timeout:
                continue
            except:
                break
        
        sock.close()
    except:
        time.sleep(2)

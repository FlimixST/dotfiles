# dots

My custom Hyprland + Quickshell setup, heavily stripped down and optimized.

This is a personal fork of [end-4's illogical-impulse](https://github.com/end-4/dots-hyprland). 

**Warning:** I built this configuration **fully for myself** and my own daily use. If you find it interesting, feel free to clone it and customize it for your needs. If you don't like my changes or want the full features, just use the official [end-4 repository](https://github.com/end-4/dots-hyprland).

---

### What I cut out

I spent two days ripping out everything I don't use to make the system fast and clean. **Almost every single file in this repository was modified/updated** because integrations like AI and other features were scattered almost everywhere, requiring a massive, codebase-wide cleanup. There might be even more things removed, I just don't remember all of them.

I deleted:
* **AI Features:** Completely deleted all Gemini, Ollama, and sidebar chat integrations. If I need AI, I'll just open Claude/Gemini in my browser.
* **Widget Modules:** Purged the lockscreen, the left AI sidebar, the widgets desktop overlay (crosshairs, notes, fps limiters), and the screen translator.
* **Deleted Configs & Scripts:**
  * Threw out the welcome screen.
  * Purged the wlogout and hyprlock configurations.
  * Deleted all screen recording scripts and hotkeys.
  * Removed obsolete configs for foot.ini, xdg-desktop-portal, zsh shells, and Kvantum.
* **Useless Features inside active widgets:**
  * Stripped out the periodic table from the cheatsheet widget (finished school 3 years ago).
  * Disabled the anime girl Booru widget (I'll use a private tab if I want to look at those).
  * Ripped out todo lists, easy effects, hypridle, night light, and bluetooth/battery indicators.
* **Removed dead package dependencies:** Cleaned up the PKGBUILD to remove unused dependencies like `qt6-multimedia`, `qt6-virtualkeyboard`, `kirigami`, `libadwaita`, `swappy` (replaced with `satty`), `wf-recorder`, and `gtk4`.

---

### My modifications & additions

* **Ghostty:** Default terminal is now Ghostty.
* **Satty:** Replaced the swappy with `satty` (Rust/GTK4 screenshot editor). It is set to float and center in Hyprland and hardcoded directly in the quickshell script.
* **Single-key binds:** Screenshots are bound to a single press of `Home`, and Google Lens search is bound to `Page_Up`. All binds for wlogout, welcome screen, and recording are gone.
* **Custom scripts:** Added my own game mode settings (`GameConfig.qml` and `game_script.py`) and Polkit rules (`polkit-nopasswd.rules`) so I don't have to type sudo every 5 seconds.
* **Clean databases:** Cleaned `Config.qml`, `Persistent.qml`, `GlobalStates.qml`, and translation files to remove all dead variables and config blocks.

*(Note: VerticalBar is still here just in case, but everything else is lean).*

---

### Installation

```bash
git clone https://github.com/FlimixST/dotfiles
cd dotfiles
./setup install
```

# This script is meant to be sourced.
# It's not for directly running.

v sudo pacman -Rns quickshell qt6-5compat qt6-positioning kdialog
for i in illogical-impulse-{audio,backlight,basic,bibata-modern-classic-bin,fonts-themes,hyprland,portal,python,screencapture,toolkit,widgets}; do
  v yay -Rns $i
done

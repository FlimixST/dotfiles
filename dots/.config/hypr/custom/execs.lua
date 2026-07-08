-- Game mode switcher
hl.on("hyprland.start", function ()
    hl.exec_cmd("python3 ~/.config/hypr/custom/scripts/game_script.py")
end)

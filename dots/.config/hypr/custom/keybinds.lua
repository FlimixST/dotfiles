hl.bind("mouse:275", hl.dsp.window.drag(), { mouse = true, description = "Window: Drag with MOUSE4" })

hl.bind("CTRL+SUPER+ALT+Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"), {description = "Edit user keybinds"} )

-- Gamemode toggle (SUPER+SHIFT+Escape)
hl.bind("SUPER + SHIFT + Escape", function()
    local mode = hl.get_current_submap()
    if mode == "gamemode" then
        hl.dispatch(hl.dsp.submap("reset"))
        hl.dispatch(hl.dsp.exec_cmd("rm -f /tmp/game_manual_lock"))
    else
        hl.dispatch(hl.dsp.submap("gamemode"))
    end
end, { submap_universal = true })

-- Inside gamemode: workspace switch + exit
hl.define_submap("gamemode", function()
    for i = 1, 3 do
        hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }), { description = "Workspace: Switch to " .. i })
    end
    hl.bind("SUPER + Escape", function()
        hl.dispatch(hl.dsp.exec_cmd("touch /tmp/game_manual_lock"))
        hl.dispatch(hl.dsp.submap("reset"))
    end)
end)


hl.bind("mouse:275", hl.dsp.window.drag(), { mouse = true, description = "Window: Drag with MOUSE4" })

hl.bind("CTRL+SUPER+ALT+Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"), {description = "Edit user keybinds"} )

hl.define_submap("gamemode", function()
    for i = 1, 10 do
        hl.bind("SUPER + " .. (i % 10), hl.dsp.focus({ workspace = i }), { description = "Workspace: Switch to " .. i })
    end
end)


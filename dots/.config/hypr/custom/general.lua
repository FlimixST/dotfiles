require("custom.variables")

-- Monitors
hl.monitor({ output = "DP-1",     mode = "1920x1080@144", position = "0x0",       scale = 1, transform = osu_transform, vrr = 0 })
hl.monitor({ output = "DVI-D-1", mode = "1920x1080@60",  position = "1920x0",     scale = 1 })
hl.monitor({ output = "HDMI-A-2", disabled = true })

-- Workspace to monitor binding
hl.workspace_rule({ workspace = "1", monitor = "DP-1" })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DVI-D-1" })
hl.workspace_rule({ workspace = "4", monitor = "DVI-D-1" })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-2" })

-- Keyboard
hl.config({
    input = {
        kb_layout = "us, ru",
        kb_options = "grp:win_space_toggle, grp:alt_shift_toggle",
        accel_profile = "flat",
        sensitivity = 0
    }
})

-- osu! tablet
hl.config({
    input = {
        tablet = {
            transform = osu_transform,
            output = "DP-1"
        }
    }
})

-- osu! immediate mode
hl.window_rule({
    match = { class = "osu.exe" },
    immediate = true
})

hl.exec_cmd("hyprctl setprop class:osu.exe immediate 1")

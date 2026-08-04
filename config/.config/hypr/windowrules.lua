--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name = "zap-float-maximized",
    match = { title = "ZAP - ZAP 2.16.1" },
    float = true,
    maximize = true,
})

hl.window_rule({
    name = "zen-profile-picker-float",
    match = { title = "Zen - Choose User Profile" },
    float = true,
})

hl.window_rule({
    name = "float-gnome-calculator",
    match = { class = "org.gnome.Calculator" },
    float = true,
})

hl.window_rule({
    name = "float-gnome-calendar",
    match = { class = "org.gnome.Calendar" },
    float = true,
})

hl.window_rule({
    name = "float-gnome-clocks",
    match = { class = "org.gnome.clocks" },
    float = true,
})

hl.window_rule({
    name = "float-png-export-dialog",
    match = { title = "Export Image as PNG" },
    float = true,
})

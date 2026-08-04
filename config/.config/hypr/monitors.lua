------------------
---- MONITORS ----
------------------

local builtin_monitor_scale = 1.0
hl.monitor({ output = "", mode = "preferred", position = "auto" })
hl.monitor({ output = "eDP-1", scale = builtin_monitor_scale })

hl.bind("switch:on:Lid Switch", function()
    hl.monitor({ output = "eDP-1", disabled = true })
end, { locked = true })

hl.bind("switch:off:Lid Switch", function()
    hl.monitor({
        output = "eDP-1",
        disabled = false,
        mode = "1920x1200@60",
        position = "auto",
        scale = builtin_monitor_scale,
    })
end, { locked = true })

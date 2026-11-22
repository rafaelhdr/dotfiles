------------------
---- MONITORS ----
------------------

local builtin_monitor_scale = 1.0
hl.monitor({ output = "", mode = "preferred", position = "auto" })

-- Top-level (not in hyprland.start) so it also applies on config reload
local function lid_closed()
    local lid_file = io.open("/proc/acpi/button/lid/LID0/state")
    if not lid_file then
        return false
    end
    local state = lid_file:read("*l")
    lid_file:close()
    return state ~= nil and state:match("closed") ~= nil
end

if lid_closed() then
    hl.monitor({ output = "eDP-1", disabled = true, scale = builtin_monitor_scale })
else
    hl.monitor({ output = "eDP-1", scale = builtin_monitor_scale })
end

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

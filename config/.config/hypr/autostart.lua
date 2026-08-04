-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    local lid_file = io.open("/proc/acpi/button/lid/LID0/state")
    if lid_file then
        local state = lid_file:read("*l")
        lid_file:close()
        if state and state:match("closed") then
            hl.monitor({ output = "eDP-1", disabled = true, scale = 1 })
        end
    end

    hl.exec_cmd("ashell --config-path ~/.config/hypr/ashell/config.toml")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("mako -c ~/.config/hypr/mako.conf")
end)

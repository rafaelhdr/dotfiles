-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("ashell --config-path ~/.config/hypr/ashell/config.toml")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("mako -c ~/.config/hypr/mako.conf")
    hl.exec_cmd("hypridle")
end)

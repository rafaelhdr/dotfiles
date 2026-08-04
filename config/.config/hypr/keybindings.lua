---------------------
---- KEYBINDINGS ----
---------------------

local vars = require("programs")

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind("CTRL + ALT + T", hl.dsp.exec_cmd("GTK_IM_MODULE=simple " .. vars.terminal))
hl.bind("CTRL + ALT + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("zen-browser -P"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(vars.fileManager))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("scrcpy --turn-screen-off -e"))

hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + G", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(vars.menu_run))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(vars.menu_drun))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

local resizeStep = 300
hl.bind(
    mainMod .. " + BRACKETLEFT",
    hl.dsp.window.resize({ x = resizeStep, y = 0, relative = true }),
    { repeating = true }
)
hl.bind(
    mainMod .. " + BRACKETRIGHT",
    hl.dsp.window.resize({ x = -resizeStep, y = 0, relative = true }),
    { repeating = true }
)

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

local workspaceKeys = { "J", "K", "M", "COMMA", "PERIOD" }
for i, key in ipairs(workspaceKeys) do
    hl.bind("CTRL + ALT + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("CTRL + ALT + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- screenshot
hl.bind("PRINT", hl.dsp.exec_cmd("flameshot gui"))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

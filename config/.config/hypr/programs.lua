---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "ghostty"
local fileManager = "nautilus"

--------------------
----  LAUNCHER  ----
--------------------

local rofi_dir = "~/.config/rofi/launchers/type-1"
local rofi_theme = "style-7"
local menu_run = "rofi -show run -theme " .. rofi_dir .. "/" .. rofi_theme .. ".rasi"
local menu_drun = "rofi -show drun -theme " .. rofi_dir .. "/" .. rofi_theme .. ".rasi"

return {
    terminal = terminal,
    fileManager = fileManager,
    menu_run = menu_run,
    menu_drun = menu_drun,
}

# Hyprland config — agent reference

Hyprland is configured entirely in Lua via the `hl` global provided by Hyprland's Lua backend. **Do not create `.conf` files for main config** — edit the relevant module below.

## File map

`hyprland.lua` is a thin entrypoint that only `require()`s the modules below, in order. Each module is a single concern — edit the one that matches your task, not `hyprland.lua` itself.

```
hyprland.lua           entrypoint: ordered require() calls only
monitors.lua            monitor outputs + lid-switch binds
programs.lua             shared vars (terminal, fileManager, launcher commands) — returns a table, required by keybindings.lua
autostart.lua            hl.on("hyprland.start", ...) — daemons/programs launched on session start
env.lua                 environment variables (hl.env)
appearance.lua           general/decoration, curves + animations, dwindle/master/scrolling, misc
input.lua                keyboard/touchpad config + gestures
keybindings.lua          all hl.bind() keybindings
windowrules.lua          hl.window_rule() rules
hyprlock.conf           lock screen (font, background, time/date/greeting widgets)
hyprpaper.conf          wallpaper path (points to ~/Pictures/Backgrounds/current.png)
hyprsunset.conf         night-light: color temperature + gamma profiles by time of day
mako.conf               notification daemon: layout, colors, urgency timeouts, DND support
workspaces.conf         workspace config (currently empty/reserved)
ashell/config.toml      status bar: modules, custom buttons, shell commands
ashell/toggle-opacity.sh    toggles inactive window opacity 0.7 ↔ 1.0 via hyprctl
scripts/ashell-mako.sh      toggles mako DND mode, streams JSON state to ashell
```

## Lua API quick reference

| Function | Purpose |
|----------|---------|
| `hl.monitor({output, mode, position, scale, disabled?, mirror?})` | Configure a monitor output |
| `hl.bind(key, action, opts?)` | Keybinding; opts: `{locked, mouse, repeating}` |
| `hl.on(event, fn)` | Event callback — use `"hyprland.start"` for autostart |
| `hl.exec_cmd(cmd)` | Run a shell command (side-effecting, for autostart) |
| `hl.config({section={...}})` | Set hyprland config variables |
| `hl.env(key, value)` | Export an environment variable |
| `hl.curve(name, {type, points?, mass?, stiffness?, dampening?})` | Define bezier or spring curve |
| `hl.animation({leaf, enabled, speed, bezier?, spring?, style?})` | Assign animation settings to a leaf |
| `hl.window_rule({name, match, ...props})` | Windowrule (float, move, size, suppress_event, …) |
| `hl.gesture({fingers, direction, action})` | Touchpad gesture binding |
| `hl.dsp.exec_cmd(cmd)` | Dispatcher: run command (use in `hl.bind`) |
| `hl.dsp.window.close()` | Dispatcher: close active window |
| `hl.dsp.window.float({action})` | Dispatcher: toggle float |
| `hl.dsp.window.fullscreen({mode, action})` | Dispatcher: fullscreen / maximize |
| `hl.dsp.window.pseudo()` | Dispatcher: toggle pseudo-tile |
| `hl.dsp.window.drag()` | Dispatcher: drag window (mouse bind) |
| `hl.dsp.window.move({workspace})` | Dispatcher: move window to workspace |
| `hl.dsp.focus({direction?, workspace?})` | Dispatcher: move focus |

## Common tasks

**Add a keybinding** — `keybindings.lua`:
```lua
hl.bind(mainMod .. " + KEY", hl.dsp.exec_cmd("some-command"))
```

**Add a window rule** — `windowrules.lua`:
```lua
hl.window_rule({
    name = "float-my-app",
    match = { class = "my-app-class" },
    float = true,
})
```

**Autostart a program** — inside the `hl.on("hyprland.start", ...)` handler in `autostart.lua`:
```lua
hl.exec_cmd("my-daemon --flag")
```

**Change gaps / borders / rounding** — general or decoration blocks in `appearance.lua`:
```lua
hl.config({ general = { gaps_in = 6, gaps_out = 6, border_size = 1 } })
hl.config({ decoration = { rounding = 10, active_opacity = 1.0, inactive_opacity = 0.7 } })
```

**Change animations** — in `appearance.lua`, edit `hl.curve(...)` definitions then `hl.animation(...)` calls (curves must stay defined before the animations that reference them).

**Monitor layout** — the catch-all rule in `monitors.lua` handles unknown outputs. Add per-monitor overrides there via `hl.monitor({output="DP-1", ...})`.

**Lid switch behavior** — `hl.bind("switch:on:Lid Switch", ...)` / `"switch:off:Lid Switch"` handlers in `monitors.lua`.

**Workspace switching keys** — edit the `workspaceKeys` table and the loop beneath it in `keybindings.lua`.

**Add a value shared across modules** (e.g. a second launcher app) — add it to the table returned by `programs.lua`, then `require("programs")` from whichever module needs it. Don't use bare global variables for this — `.luacheckrc` only whitelists `hl` as a global for this directory, so an undeclared global will fail CI lint.

## Linting and formatting

`.luacheckrc` and `stylua.toml` live at the **dotfiles repo root** (one level above this directory), not here. CI (`.github/workflows/lint.yml`) runs both automatically on every push/PR to `main` that touches `config/.config/hypr/**` — so lint/format issues are caught even if you don't run these locally. Still worth running before merging:

```bash
# lint
luacheck config/.config/hypr/ --no-color --codes

# format check
stylua --check config/.config/hypr/

# format apply
stylua config/.config/hypr/
```

Config: `.luacheckrc` (max line 140, global `hl` declared), `stylua.toml` (4-space indent, 120 col).

## Reference

Hyprland Lua config wiki: https://wiki.hypr.land/Configuring/

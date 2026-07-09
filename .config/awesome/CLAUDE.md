# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal AwesomeWM configuration (Lua). AwesomeWM loads `rc.lua` from this directory at start. `rc.lua` declares `-- awesome_mode: api-level=4:screen=on` — this config targets the **AwesomeWM 4.x API**, so do not use v3 idioms (e.g. old signal names, `awful.rules` — use `ruled.client` instead, no `awful.util.spawn` for new code, etc.).

## Iteration workflow

`Taskfile.yml` (invoked via `go-task`, the binary from the Arch `go-task` package) is the entry point for anything that isn't a one-line tweak. **Prefer these tasks over ad-hoc commands** so the syntax-check gate is never skipped.

- Small change → edit → `go-task check` → `Mod+Ctrl+R` (or `go-task reload`).
- Bigger change / refactor → `go-task test:sync` → edit inside `test/` → `go-task xephyr:test` (nested X server, isolated from the running session) → `go-task promote` → reload.

`test/` is a **full parallel copy** of the config (not symlinks). This is intentional: refactors happen in `test/` and are promoted atomically, so the live config is never in a half-refactored state. `promote` runs `check:test` first and refuses if it fails.

**Do not sync `test/` in either direction manually** — always use `go-task test:sync` / `go-task promote` so the exclude list (Taskfile.yml, README.md, CLAUDE.md, .git) is respected. Direct `cp -r` will clobber those meta files.

**Known caveat for the test workflow:** `rc.lua` line 50 hardcodes `beautiful.init("~/.config/awesome/theme/theme.lua")` — an absolute path to the *live* theme. So theme changes inside `test/theme/` are NOT picked up when running `xephyr:test`. Widget and rc.lua changes ARE isolated (Lua's `require` resolves relative to the `-c` config dir). Fix when convenient: replace with `beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")`.

## Recovery

- Runtime errors (signal handlers, widget updates) don't crash awesome — they show as `naughty` notifications via the `request::display_error` handler.
- Load-time errors → awesome falls back to `/etc/xdg/awesome/rc.lua`. Startup error surfaces in `~/.xsession-errors`.
- If a reload breaks the bar but the WM survives, `Mod+Return` almost always still opens a terminal.

## Architecture

- **`rc.lua`** — the entire session config: theme init, wibar layout, tags, keybindings, mouse bindings, client rules, titlebars, notifications, autostart. Sections are demarcated by `-- {{{ ... -- }}}` fold markers; preserve them when editing.
- **`theme/theme.lua`** — `beautiful` theme table. Picks a random wallpaper from `theme/wallpapers/` on each load (uses `lfs.dir`). Colors use an `"#rrggbb" .. "aa"` alpha suffix pattern to get translucency (works with picom composited).
- **`xrandr.lua`** — monitor arrangement cycler. Bound to `Mod+p`. Enumerates connected outputs via `xrandr -q`, generates all left-to-right permutations, and cycles through them via a `naughty` notification (confirming via expiry or dismissal runs the `xrandr` command).
- **`widgets/<name>/<name>.lua`** — vendored widgets from streetturtle/awesome-wm-widgets (each has its own upstream README kept in the widget folder). All follow the same pattern:
  ```lua
  local widget = {}
  local function worker(args) ... return widget end
  return setmetatable(widget, { __call = function(_, ...) return worker(...) end })
  ```
  So `require("widgets.foo.foo")` returns a table you call like a function to instantiate: `foo_widget({option = ...})`. When adding/modifying a widget, keep this callable-module contract.

## Widget wiring (where to look when the bar breaks)

The right side of the wibar is assembled in the `screen.connect_signal("request::desktop_decoration", ...)` handler in `rc.lua` (~line 213). Widgets are separated by `wibox.widget.textbox("  ")` spacers.

- **Volume** (`widgets/volume/volume.lua`) — uses `amixer -D pulse` + `pacmd`. Has multiple visual variants under `widgets/volume/widgets/` (`arc`, `icon`, `icon_and_text`, `horizontal_bar`, `vertical_bar`) selected via `widget_type` arg. The `volume` module exposes `:inc()`, `:dec()`, `:toggle()` methods that `XF86Audio*` keys call into — those methods are only defined *inside* `worker()`, so they exist only after the widget has been instantiated (calling them before the wibar is built will fail silently).
- **Battery** (`widgets/battery/battery.lua`) — parses `acpi -i` every 10s, uses icons from `/usr/share/icons/Arc/status/symbolic/` (path is configurable via `path_to_icons` arg).
- **Brightness** (`widgets/brightness/brightness.lua`) — defaults to `light` CLI, but `rc.lua` overrides to `xbacklight` via constructor args. The `XF86MonBrightness{Up,Down}` keys spawn `xbacklight` **directly** (not through the widget), so if you switch backends update both places.
- **Spotify** (`widgets/spotify/spotify.lua`) — depends on the bundled `widgets/spotify/sp` script (must be on PATH or invoked from that folder). Polls `sp status` and `sp current-oneline` every 1s.
- **Calendar** (`widgets/calendar/calendar.lua`) — popup toggled by clicking the textclock (wired via `mytextclock:connect_signal("button::press", ...)` in `rc.lua`).

## External dependencies

`rc.lua` spawns/relies on: `kitty` (terminal), `google-chrome-stable`, `firefox`, `thunderbird`, `wasistlos` (WhatsApp), `slack`, `pidgin`, `vmware-view`, `thunar`, `rofi` (+ Papirus icons + solarized rofi theme), `picom`, `nm-applet`, `blueman-applet`, `xfce4-clipman`, `udiskie`, `prismatik`, `shutter`, `slock`, `playerctl`, `xbacklight`, `amixer`, `pacmd`, `acpi`, `light` (used by widget defaults even though brightness widget is overridden), `systemctl`. Missing binaries cause silent spawn failures — check `awful.spawn` calls when a keybinding "does nothing."

## Conventions

- **Modkey is `Mod4`** (Super). Keybindings are appended in themed groups via `awful.keyboard.append_global_keybindings({...})` — new bindings should follow the same group convention and set `{description=..., group=...}` so they appear in the `Mod+s` hotkeys popup.
- **Client rules** live in the `ruled.client.connect_signal("request::rules", ...)` block. Titlebars are disabled globally via the `"titlebars"` rule (`titlebars_enabled = false`); the `request::titlebars` handler at the bottom still exists in case a rule ever re-enables them.
- **Autostart** is at the bottom of `rc.lua` as `awful.spawn.with_shell(...)` calls. These fire on *every* restart, so they must be idempotent (the tools listed all self-check for an existing instance).
- Commented-out `screen:fake_resize` / `screen.fake_add` blocks near the bottom of `rc.lua` are intentional — toggled manually when working on split-monitor setups. Don't delete.

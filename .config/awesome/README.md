# AwesomeWM configuration

Personal [AwesomeWM](https://awesomewm.org/) 4.x configuration. Tracked in my dotfiles bare repo.

## Dependencies

Required at runtime:

- `awesome` — the window manager itself
- `kitty` — default terminal
- `rofi` (+ `papirus-icon-theme` for `-icon-theme Papirus`) — launcher / calculator
- `picom` — compositor
- `nm-applet`, `blueman-applet`, `xfce4-clipman`, `udiskie`, `prismatik` — tray apps autostarted at login
- `xbacklight` (or `acpilight` for non-Intel GPUs) — brightness
- `alsa-utils` (`amixer`), `pulseaudio` or `pipewire-pulse` (`pacmd`) — volume
- `acpi` — battery
- `playerctl` — media keys
- `shutter` — screenshots (bound to `Print`)
- `slock` — screen lock (`Mod+Alt+l`)

Required for the development workflow (this README's `go-task` commands):

- `go-task` — the task runner (`pacman -S go-task`)
- `xorg-server-xephyr` — nested X server for `xephyr` tasks
- `rsync` — used by `test:sync` and `promote`

## Layout

```
.
├── rc.lua              # main config — loaded by awesome at startup
├── theme/              # colors, wallpapers, taglist assets
├── widgets/            # vendored streetturtle widgets (battery, volume, brightness, spotify, calendar)
├── xrandr.lua          # Mod+p monitor-arrangement cycler
├── test/               # full copy of the config for isolated refactor work
├── Taskfile.yml        # go-task commands (see below)
├── README.md           # this file
└── CLAUDE.md           # architecture notes for AI assistants
```

## Workflow

### Small changes

Tweak a color, add a keybinding, change a widget option:

```
$EDITOR rc.lua              # or wherever
go-task check               # awesome -k -c rc.lua
```

Then in the running WM: **`Mod+Ctrl+R`** — this calls `awesome.restart()`, which reloads the config in place without killing your session. (`go-task reload` does the same thing from outside the WM.)

If `check` fails, don't reload — fix the syntax first.

### Bigger changes / refactors

For anything that could leave the config in a half-broken state (bar redesign, widget rewrite, restructuring `rc.lua`):

```
go-task test:sync           # copy live -> test/ (wipes uncommitted test work)
$EDITOR test/rc.lua         # edit inside test/
go-task xephyr:test         # boot a nested awesome using test/
                            # iterate until happy — closing the Xephyr window exits
go-task test:diff           # optional: review what changed vs live
go-task promote             # copy test/ -> live (after check:test passes)
Mod+Ctrl+R                  # or `go-task reload`
```

`promote` runs `check:test` first, so it refuses to overwrite live with a broken test config.

### Debugging a running session

- **`awesome-client`** — pipe Lua into the running WM. Example: `echo 'return #client.get()' | awesome-client`.
- **`Mod+X`** — opens a Lua eval prompt inside the WM (`awful.prompt.run`).
- **`~/.xsession-errors`** — where startup and stderr end up.
- **`request::display_error`** notifications — critical errors surface as red naughty popups (see the handler at the top of `rc.lua`).

### Recovering from a broken reload

If `Mod+Ctrl+R` leaves the bar broken but the WM alive:

- `Mod+Return` still opens a terminal in almost every broken state. Fix the file, `go-task check`, reload.

If AwesomeWM fails to load at all, it falls back to `/etc/xdg/awesome/rc.lua` — you'll get an ugly-but-working desktop. Fix your `rc.lua` and log out/in (or `go-task reload`).

## Task reference

Run `go-task` (no args) or `go-task --list` for the current list. Key tasks:

| Task | Purpose |
|---|---|
| `check` | `awesome -k -c rc.lua` |
| `check:test` | `awesome -k -c test/rc.lua` |
| `reload` | check → `awesome.restart()` on the running WM |
| `xephyr` | Nested awesome with live config on display `:5` |
| `xephyr:test` | Nested awesome with test config on display `:5` |
| `test:sync` | live → test/ (prompts; use `--yes` to skip) |
| `test:diff` | Show diff between live and test/ |
| `promote` | test/ → live (runs `check:test` first, prompts) |
| `clean` | Kill stray Xephyr processes |

## Credits

Widgets under `widgets/` are vendored copies from [streetturtle/awesome-wm-widgets](https://github.com/streetturtle/awesome-wm-widgets). `xrandr.lua` is adapted from the AwesomeWM wiki.

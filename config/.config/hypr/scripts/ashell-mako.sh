#!/bin/sh
set -eu

STATE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/ashell"
STATE_FILE="$STATE_DIR/mako-mode"

require_inotify() {
  if ! command -v inotifywait >/dev/null 2>&1; then
    echo "Error: inotifywait not found. Install: sudo pacman -S inotify-tools" >&2
    exit 1
  fi
}

read_mako_mode() {
  # makoctl prints e.g. "default" or "do-not-disturb"
  makoctl mode 2>/dev/null | tr -d '\r' || printf 'default'
}

write_state() {
  mkdir -p "$STATE_DIR"
  printf '%s\n' "$1" > "$STATE_FILE"
}

print_json() {
  mode="$1"
  if [ "$mode" = "do-not-disturb" ]; then
    printf '{"text":"","alt":"dnd"}\n'
  else
    printf '{"text":"","alt":"default"}\n'
  fi
}

toggle_mode() {
  current="$(read_mako_mode)"

  if [ "$current" = "default" ]; then
    makoctl mode -s do-not-disturb >/dev/null
    write_state "do-not-disturb"
  else
    makoctl mode -s default >/dev/null
    write_state "default"
  fi
}

listen_mode() {
  require_inotify

  current="$(read_mako_mode)"
  write_state "$current"
  print_json "$current"

  # Event-driven updates: react only when the state file changes
  while :; do
    inotifywait -q -e close_write,move,create "$STATE_DIR" >/dev/null 2>&1 || true

    mode="$(cat "$STATE_FILE" 2>/dev/null || printf 'default')"
    mode="$(printf '%s' "$mode" | tr -d '\r\n')"
    [ -n "$mode" ] || mode="default"

    print_json "$mode"
  done
}

usage() {
  cat <<EOF
Usage: $(basename "$0") <toggle|listen>

toggle  Toggle mako between 'default' and 'do-not-disturb' and update the state file.
listen  Print JSON for Ashell and update only on state file changes (inotify).
EOF
}

case "${1:-}" in
  toggle) toggle_mode ;;
  listen) listen_mode ;;
  *) usage; exit 2 ;;
esac


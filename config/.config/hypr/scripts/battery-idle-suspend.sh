#!/bin/bash
# Started by hypridle's on-timeout after IDLE_TIMEOUT_SECONDS idle; killed by
# on-resume on input. While idle, polls every TICK_WAITING_TIME so a battery
# drop below BATTERY_THRESHOLD during a long idle stretch (e.g. unplugged
# mid-download) still triggers suspend, not just a one-time check at the
# 5-minute mark.

readonly IDLE_TIMEOUT_SECONDS=300 # must match the listener's timeout in hypridle.conf
readonly TICK_WAITING_TIME=30     # how often to re-check AC/battery while idle
readonly BATTERY_THRESHOLD=50     # suspend only if battery is below this percent

pidfile="${XDG_RUNTIME_DIR:-/tmp}/battery-idle-suspend.pid"

if [ "$1" = "stop" ]; then
    [ -f "$pidfile" ] && kill "$(cat "$pidfile")" 2>/dev/null
    rm -f "$pidfile"
    exit 0
fi

echo $$ >"$pidfile"

while true; do
    ac_online=$(cat /sys/class/power_supply/ACAD/online 2>/dev/null)
    if [ "$ac_online" != "1" ]; then
        capacity=$(cat /sys/class/power_supply/BAT1/capacity 2>/dev/null)
        if [ -n "$capacity" ] && [ "$capacity" -lt "$BATTERY_THRESHOLD" ]; then
            hyprlock &
            sleep 1
            systemctl suspend
            break
        fi
    fi
    sleep "$TICK_WAITING_TIME"
done

rm -f "$pidfile"

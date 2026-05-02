#!/usr/bin/env bash
# Toggle screen mirroring between eDP-1 and external monitor

# Function to send notification (if notify-send is available)
notify() {
    if command -v notify-send &> /dev/null; then
        notify-send "Screen Mirror" "$1" -t 2000
    else
        echo "Screen Mirror: $1"
    fi
}

# Get the external monitor name (first non-eDP monitor)
EXTERNAL_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.name != "eDP-1") | .name' | head -1)

if [ -z "$EXTERNAL_MONITOR" ]; then
    notify "No external monitor detected!"
    exit 1
fi

if pgrep -x "wl-mirror" > /dev/null; then
    # Mirror is running, stop it
    pkill -9 wl-mirror
    notify "Mirror stopped"
else
    # Start mirror with screencopy-shm backend (works without DMA-BUF)
    wl-mirror --backend screencopy-shm --fullscreen-output "$EXTERNAL_MONITOR" eDP-1 &
    notify "Mirroring eDP-1 to $EXTERNAL_MONITOR"
fi

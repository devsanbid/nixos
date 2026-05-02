#!/usr/bin/env bash
# Fast display mirroring script for NVIDIA GPUs
# Uses wf-recorder with GPU encoding + mpv for low-latency playback

SOURCE_OUTPUT="$1"
TARGET_OUTPUT="$2"

if [ -z "$SOURCE_OUTPUT" ] || [ -z "$TARGET_OUTPUT" ]; then
    echo "Usage: $0 <source-output> <target-output>"
    echo "Example: $0 HDMI-A-5 eDP-1"
    exit 1
fi

# Use wf-recorder with VAAPI hardware encoding and pipe to mpv
# This provides GPU-accelerated capture and playback
wf-recorder --muxer=mpegts --codec=h264_vaapi --file=- -o "$SOURCE_OUTPUT" 2>/dev/null | \
    mpv --untimed --no-cache --profile=low-latency --video-sync=display-resample \
        --hwdec=auto --gpu-context=wayland --fullscreen --screen="$TARGET_OUTPUT" - \
        2>/dev/null &

echo "Mirroring $SOURCE_OUTPUT to $TARGET_OUTPUT (PID: $!)"
echo "Press Ctrl+C to stop"
wait

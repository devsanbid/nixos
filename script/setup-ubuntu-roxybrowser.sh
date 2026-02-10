#!/usr/bin/env bash
# Script to create Ubuntu distrobox and install RoxyBrowser
# Run this after rebuilding NixOS with distrobox enabled

set -e

CONTAINER_NAME="ubuntu-roxy"
DEB_URL="https://sgp1.vultrobjects.com/roxybrowseross/public/package/app/Linux/x64/3.7.1/RoxyBrowser_x64_3.7.1.deb?response-content-disposition=attachment%3B%20filename%3D%22RoxyBrowser_x64_3.7.1_2026_02_10-H-01045PFA__404058a58702650cb8f0231cae8831711770695674.deb%22&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=N50QEQVFJL66EKTB0R2A%2F20260210%2Fsgp1%2Fs3%2Faws4_request&X-Amz-Date=20260210T035756Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=446072f030c89e9dfba137b5660ca8ad5ce43ad60c76cd016dd5c9cafe677000"

echo "=== Setting up Distrobox with Ubuntu and RoxyBrowser ==="

# Allow X server connections from local (required for GUI)
echo "[1/5] Allowing X server connections..."
xhost +local: 2>/dev/null || true

# Create Ubuntu distrobox if it doesn't exist
if ! distrobox list | grep -q "$CONTAINER_NAME"; then
    echo "[2/5] Creating Ubuntu distrobox container..."
    distrobox create --name "$CONTAINER_NAME" --image ubuntu:22.04 --yes
else
    echo "[2/5] Ubuntu distrobox already exists, skipping creation..."
fi

echo "[3/5] Installing dependencies and downloading RoxyBrowser..."
distrobox enter "$CONTAINER_NAME" -- bash -c "
    set -e
    echo 'Updating package lists...'
    sudo apt-get update -qq
    
    echo 'Installing dependencies...'
    sudo apt-get install -y -qq wget libgtk-3-0 libnotify4 libnss3 libxss1 libxtst6 xdg-utils libatspi2.0-0 libsecret-1-0 libasound2 libgbm1 2>/dev/null
    
    echo 'Downloading RoxyBrowser...'
    cd /tmp
    wget -q --show-progress -O RoxyBrowser.deb '$DEB_URL'
    
    echo 'Installing RoxyBrowser...'
    sudo dpkg -i RoxyBrowser.deb || sudo apt-get install -f -y -qq
    
    echo 'Cleaning up...'
    rm -f /tmp/RoxyBrowser.deb
    
    echo 'RoxyBrowser installed successfully!'
"

echo "[4/5] Exporting RoxyBrowser to host..."
distrobox enter "$CONTAINER_NAME" -- bash -c "
    # Find and export the RoxyBrowser application
    if command -v roxy-browser &>/dev/null; then
        distrobox-export --app roxy-browser 2>/dev/null || true
    elif [ -f /usr/bin/RoxyBrowser ]; then
        distrobox-export --app RoxyBrowser 2>/dev/null || true
    elif [ -f /opt/RoxyBrowser/roxy-browser ]; then
        distrobox-export --bin /opt/RoxyBrowser/roxy-browser --export-path ~/.local/bin 2>/dev/null || true
    fi
    
    # Export any .desktop files
    for desktop_file in /usr/share/applications/*roxy*.desktop /usr/share/applications/*Roxy*.desktop; do
        if [ -f \"\$desktop_file\" ]; then
            app_name=\$(basename \"\$desktop_file\" .desktop)
            distrobox-export --app \"\$app_name\" 2>/dev/null || true
        fi
    done
"

echo "[5/5] Setup complete!"
echo ""
echo "=== How to use RoxyBrowser ==="
echo "Option 1: Run from terminal:"
echo "  distrobox enter $CONTAINER_NAME -- roxy-browser"
echo ""
echo "Option 2: If exported successfully, you can find it in your application menu"
echo "  or run: ~/.local/bin/roxy-browser"
echo ""
echo "Note: Make sure to run 'xhost +local:' before launching GUI apps if you get display errors"

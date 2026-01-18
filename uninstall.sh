#!/bin/bash
# Uninstall script for Mac Notch Widget

set -e

WAYBAR_NOTCH_DIR="$HOME/.config/waybar/notch"
AUTOSTART_FILE="$HOME/.config/hypr/autostart.conf"

echo "Uninstalling Mac Notch Widget..."

# Kill running notch waybar
pkill -f "waybar.*notch/config.jsonc" 2>/dev/null || true

# Remove notch config directory
if [ -d "$WAYBAR_NOTCH_DIR" ]; then
    rm -rf "$WAYBAR_NOTCH_DIR"
    echo "Removed $WAYBAR_NOTCH_DIR"
fi

# Remove from autostart
if [ -f "$AUTOSTART_FILE" ]; then
    sed -i '/# Notch widget/d' "$AUTOSTART_FILE"
    sed -i '/waybar.*notch\/config.jsonc/d' "$AUTOSTART_FILE"
    echo "Removed from Hyprland autostart"
fi

echo "Uninstallation complete!"

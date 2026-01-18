#!/bin/bash
# Install script for Mac Notch Widget
# For Omarchy Linux on Apple Silicon Macs

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WAYBAR_NOTCH_DIR="$HOME/.config/waybar/notch"

echo "Installing Mac Notch Widget..."

# Create notch config directory
mkdir -p "$WAYBAR_NOTCH_DIR"

# Copy widget files
cp "$SCRIPT_DIR/config.jsonc" "$WAYBAR_NOTCH_DIR/"
cp "$SCRIPT_DIR/style.css" "$WAYBAR_NOTCH_DIR/"
cp "$SCRIPT_DIR/restart.sh" "$WAYBAR_NOTCH_DIR/"
chmod +x "$WAYBAR_NOTCH_DIR/restart.sh"

echo "Widget files installed to $WAYBAR_NOTCH_DIR"

# Add to autostart if not already present
AUTOSTART_FILE="$HOME/.config/hypr/autostart.conf"
AUTOSTART_LINE="exec-once = waybar -c ~/.config/waybar/notch/config.jsonc -s ~/.config/waybar/notch/style.css"

if [ -f "$AUTOSTART_FILE" ]; then
    if ! grep -q "waybar.*notch/config.jsonc" "$AUTOSTART_FILE"; then
        echo "" >> "$AUTOSTART_FILE"
        echo "# Notch widget - hover to reveal media controls and system info" >> "$AUTOSTART_FILE"
        echo "$AUTOSTART_LINE" >> "$AUTOSTART_FILE"
        echo "Added to Hyprland autostart"
    else
        echo "Already in Hyprland autostart"
    fi
else
    echo "Warning: $AUTOSTART_FILE not found. Add this to your autostart manually:"
    echo "  $AUTOSTART_LINE"
fi

echo ""
echo "Installation complete!"
echo ""
echo "To start the widget now, run:"
echo "  waybar -c ~/.config/waybar/notch/config.jsonc -s ~/.config/waybar/notch/style.css &"
echo ""
echo "Or restart both waybars with:"
echo "  ~/.config/waybar/notch/restart.sh"

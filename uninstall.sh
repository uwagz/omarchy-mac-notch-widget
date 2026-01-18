#!/bin/bash
# Uninstall script for Mac Notch Widget

set -e

WAYBAR_NOTCH_DIR="$HOME/.config/waybar/notch"
AUTOSTART_FILE="$HOME/.config/hypr/autostart.conf"
HOOKS_DIR="$HOME/.config/omarchy/hooks"
HOOK_FILE="$HOOKS_DIR/theme-set"

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
    # Clean up any empty lines at end of file
    sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' "$AUTOSTART_FILE" 2>/dev/null || true
    echo "Removed from Hyprland autostart"
fi

# Remove from theme-set hook
if [ -f "$HOOK_FILE" ]; then
    # Remove notch-widget lines from hook
    sed -i '/# notch-widget/d' "$HOOK_FILE"
    sed -i '/waybar.*notch\/config.jsonc/d' "$HOOK_FILE"
    
    # Check if hook file is now empty (only shebang and comments)
    CONTENT=$(grep -v '^#' "$HOOK_FILE" | grep -v '^$' | grep -v '^THEME_NAME' || true)
    if [ -z "$CONTENT" ]; then
        rm "$HOOK_FILE"
        echo "Removed empty theme-set hook"
    else
        echo "Removed notch restart from theme-set hook (hook has other content)"
    fi
fi

echo ""
echo "Uninstallation complete!"
echo "The main waybar is unaffected."

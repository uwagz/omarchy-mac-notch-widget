#!/bin/bash
# Install script for Mac Notch Widget
# For Omarchy Linux on Apple Silicon Macs

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WAYBAR_NOTCH_DIR="$HOME/.config/waybar/notch"
HOOKS_DIR="$HOME/.config/omarchy/hooks"

echo "Installing Mac Notch Widget..."

# Create notch config directory
mkdir -p "$WAYBAR_NOTCH_DIR/scripts"

# Copy widget files
cp "$SCRIPT_DIR/config.jsonc" "$WAYBAR_NOTCH_DIR/"
cp "$SCRIPT_DIR/style.css" "$WAYBAR_NOTCH_DIR/"
cp "$SCRIPT_DIR/restart.sh" "$WAYBAR_NOTCH_DIR/"
chmod +x "$WAYBAR_NOTCH_DIR/restart.sh"

# Copy scripts
if [ -d "$SCRIPT_DIR/scripts" ]; then
    cp "$SCRIPT_DIR/scripts/"* "$WAYBAR_NOTCH_DIR/scripts/"
    chmod +x "$WAYBAR_NOTCH_DIR/scripts/"*
fi

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

# Install theme-set hook for automatic restart on theme change
mkdir -p "$HOOKS_DIR"
HOOK_FILE="$HOOKS_DIR/theme-set"

# Check if hook already exists and has other content
if [ -f "$HOOK_FILE" ]; then
    if ! grep -q "notch-widget" "$HOOK_FILE"; then
        # Append to existing hook
        echo "" >> "$HOOK_FILE"
        echo "# notch-widget: Restart notch waybar on theme change" >> "$HOOK_FILE"
        echo "pkill -f 'waybar.*notch/config.jsonc' 2>/dev/null; sleep 0.3; waybar -c ~/.config/waybar/notch/config.jsonc -s ~/.config/waybar/notch/style.css &" >> "$HOOK_FILE"
        echo "Added notch restart to existing theme-set hook"
    else
        echo "Notch restart already in theme-set hook"
    fi
else
    # Create new hook
    cat > "$HOOK_FILE" << 'EOF'
#!/bin/bash
# Theme-set hook - runs after omarchy-theme-set
THEME_NAME=$1

# notch-widget: Restart notch waybar on theme change
pkill -f 'waybar.*notch/config.jsonc' 2>/dev/null
sleep 0.3
waybar -c ~/.config/waybar/notch/config.jsonc -s ~/.config/waybar/notch/style.css &
EOF
    chmod +x "$HOOK_FILE"
    echo "Created theme-set hook"
fi

echo ""
echo "Installation complete!"
echo ""
echo "To start the widget now, run:"
echo "  waybar -c ~/.config/waybar/notch/config.jsonc -s ~/.config/waybar/notch/style.css &"
echo ""
echo "Or restart both waybars with:"
echo "  ~/.config/waybar/notch/restart.sh"
echo ""
echo "The widget will:"
echo "  - Start automatically on login"
echo "  - Restart automatically when you change themes"

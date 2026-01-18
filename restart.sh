#!/bin/bash
# Restart both main waybar and notch waybar

# Kill existing notch waybar (identified by its config path)
pkill -f "waybar.*notch/config.jsonc" 2>/dev/null

# Restart main waybar
omarchy-restart-waybar

# Small delay to let main waybar start
sleep 0.3

# Start notch waybar
waybar -c ~/.config/waybar/notch/config.jsonc -s ~/.config/waybar/notch/style.css &

echo "Both waybars restarted"

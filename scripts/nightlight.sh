#!/bin/bash
# Output nightlight status for waybar

OFF_TEMP=6000

# Get current temperature
CURRENT_TEMP=$(hyprctl hyprsunset temperature 2>/dev/null | grep -oE '[0-9]+')

if [[ "$CURRENT_TEMP" == "$OFF_TEMP" ]] || [[ -z "$CURRENT_TEMP" ]]; then
    echo '{"text": "Off 󰖨", "class": "off"}'
else
    echo '{"text": "On 󰖨", "class": "on"}'
fi

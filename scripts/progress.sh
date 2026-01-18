#!/bin/bash
# Output media progress bar for waybar

# Get position and length in microseconds
POSITION=$(playerctl metadata --format '{{position}}' 2>/dev/null)
LENGTH=$(playerctl metadata --format '{{mpris:length}}' 2>/dev/null)

if [ -z "$POSITION" ] || [ -z "$LENGTH" ] || [ "$LENGTH" = "0" ]; then
    echo '{"text": "", "class": "empty"}'
    exit 0
fi

# Calculate percentage
PERCENT=$((POSITION * 100 / LENGTH))

# Convert to mm:ss format
POS_SEC=$((POSITION / 1000000))
LEN_SEC=$((LENGTH / 1000000))
POS_MIN=$((POS_SEC / 60))
POS_REM=$((POS_SEC % 60))
LEN_MIN=$((LEN_SEC / 60))
LEN_REM=$((LEN_SEC % 60))

TIME_STR=$(printf "%d:%02d / %d:%02d" $POS_MIN $POS_REM $LEN_MIN $LEN_REM)

# Create progress bar (20 chars wide)
BAR_WIDTH=16
FILLED=$((PERCENT * BAR_WIDTH / 100))
EMPTY=$((BAR_WIDTH - FILLED))

BAR=""
for ((i=0; i<FILLED; i++)); do BAR+="━"; done
for ((i=0; i<EMPTY; i++)); do BAR+="─"; done

# Output JSON for waybar
echo "{\"text\": \"$BAR  $TIME_STR\", \"class\": \"progress\", \"percentage\": $PERCENT}"

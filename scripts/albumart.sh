#!/bin/bash
# Fetch album art and output path for waybar image module

ART_PATH="/tmp/waybar-albumart.png"
ART_HASH_FILE="/tmp/waybar-albumart-hash"

# Cleanup any stale albumart files older than 1 day (runs occasionally)
if [ $((RANDOM % 100)) -eq 0 ]; then
    find /tmp -name "waybar-albumart*" -mtime +1 -delete 2>/dev/null
fi

ART_URL=$(playerctl metadata --format '{{mpris:artUrl}}' 2>/dev/null)

if [ -z "$ART_URL" ]; then
    rm -f "$ART_PATH" 2>/dev/null
    rm -f "$ART_HASH_FILE" 2>/dev/null
    echo ""
    exit 0
fi

# Hash to detect changes
NEW_HASH=$(echo "$ART_URL" | md5sum | cut -d' ' -f1)
OLD_HASH=""
[ -f "$ART_HASH_FILE" ] && OLD_HASH=$(cat "$ART_HASH_FILE")

if [ "$OLD_HASH" != "$NEW_HASH" ]; then
    if [[ "$ART_URL" == file://* ]]; then
        SRC_PATH="${ART_URL#file://}"
        [ -f "$SRC_PATH" ] && cp "$SRC_PATH" "$ART_PATH" 2>/dev/null
    elif [[ "$ART_URL" == http* ]]; then
        curl -s -o "$ART_PATH" "$ART_URL" 2>/dev/null
    fi
    echo "$NEW_HASH" > "$ART_HASH_FILE"
fi

# Output path for waybar image module
if [ -f "$ART_PATH" ] && [ -s "$ART_PATH" ]; then
    echo "$ART_PATH"
else
    echo ""
fi

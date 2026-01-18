#!/bin/bash
# Weather script using Nerd Font icons instead of colored emojis
# Maps wttr.in %x codes to monochrome Nerd Font weather icons

# Get weather data: %x = plain text icon, %t = temperature
data=$(curl -s 'wttr.in/?format=%x+%t' 2>/dev/null)

if [[ -z "$data" || "$data" == *"Unknown"* ]]; then
    echo "󰖐  --"
    exit 0
fi

# Extract icon code and temperature
icon_code=$(echo "$data" | awk '{print $1}')
temp=$(echo "$data" | awk '{print $2}')

# Map wttr.in %x codes to Nerd Font weather icons
# See: https://github.com/chubin/wttr.in
# Nerd Font weather icons: https://www.nerdfonts.com/cheat-sheet (search "weather")
case "$icon_code" in
    "o")     icon="󰖙" ;;  # Sunny / Clear
    "O")     icon="󰖙" ;;  # Sunny
    "c")     icon="󰖐" ;;  # Cloudy
    "C")     icon="󰖐" ;;  # Cloudy
    "m")     icon="󰖐" ;;  # Cloudy (mist)
    ".")     icon="󰼱" ;;  # Sunny intervals, no rain
    ",")     icon="󰼱" ;;  # Sunny intervals, no rain  
    "b")     icon="󰖕" ;;  # Partly cloudy
    "B")     icon="󰖕" ;;  # Partly cloudy
    "h")     icon="󰖑" ;;  # Hazy
    "H")     icon="󰖑" ;;  # Hazy / Fog
    "g")     icon="󰖑" ;;  # Fog
    "G")     icon="󰖑" ;;  # Fog / Dense fog
    "s")     icon="󰼶" ;;  # Light snow
    "S")     icon="󰖘" ;;  # Heavy snow
    "i")     icon="󰖘" ;;  # Sleet
    "I")     icon="󰖘" ;;  # Sleet
    "w")     icon="󰖗" ;;  # Light snow showers
    "W")     icon="󰖘" ;;  # Heavy snow showers
    "r")     icon="󰖖" ;;  # Light rain
    "R")     icon="󰖖" ;;  # Heavy rain
    "p")     icon="󰖖" ;;  # Light rain showers
    "P")     icon="󰖖" ;;  # Heavy rain showers
    "d")     icon="󰼳" ;;  # Drizzle
    "D")     icon="󰖖" ;;  # Heavy drizzle
    "t")     icon="󰖓" ;;  # Thunderstorm
    "T")     icon="󰖓" ;;  # Thunderstorm
    "l")     icon="󰙾" ;;  # Lightning
    "L")     icon="󰖓" ;;  # Lightning / Thunder
    "x")     icon="󰖖" ;;  # Sleet showers
    "X")     icon="󰖘" ;;  # Heavy sleet showers
    "u")     icon="󰖐" ;;  # Unknown precipitation
    "U")     icon="󰖐" ;;  # Unknown precipitation
    "?")     icon="󰖐" ;;  # Unknown
    "mmm")   icon="󰖑" ;;  # Fog
    "/")     icon="󰖕" ;;  # Partly cloudy
    "\\")    icon="󰖕" ;;  # Partly cloudy
    *)       icon="󰖐" ;;  # Default: cloudy
esac

echo "$icon  $temp"

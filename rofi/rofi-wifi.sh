#!/bin/bash

# Close if already running
if pgrep -x rofi >/dev/null; then
    pkill -x rofi
    exit 0
fi

# Show a loading window
echo "Scanning for Wi-Fi networks..." | \
    rofi -dmenu -p "Wi-Fi" -no-custom &
ROFI_PID=$!

# Scan in the background
nmcli device wifi rescan >/dev/null 2>&1
NETWORKS=$(nmcli -t -f SSID dev wifi list | sed '/^$/d' | sort -u)

# Close the loading window
kill "$ROFI_PID" 2>/dev/null

# Show the actual menu
SSID=$(echo "$NETWORKS" | rofi -dmenu -i -p "Wi-Fi")

[ -z "$SSID" ] && exit 0

nmcli dev wifi connect "$SSID"

if [ $? -eq 0 ]; then
    notify-send "Wi-Fi" "Connected to $SSID"
else
    notify-send "Wi-Fi" "Connection failed or cancelled"
fi
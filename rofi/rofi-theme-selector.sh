#!/bin/bash

# Define your themes and their corresponding scripts
# Using correct full paths
THEMES=(
    "Atsu|/home/spectre/.config/rofi/scripts/ghost_yotei.sh"
    "Dutch Van Der Linde|/home/spectre/.config/rofi/scripts/dutch_rdr.sh"
    "Mia Winters|/home/spectre/.config/rofi/scripts/mia_winters.sh"
    "Saint Nerona Imu|/home/spectre/.config/rofi/scripts/imu_sama.sh"
    "Kawaki Uzumaki|/home/spectre/.config/rofi/scripts/kawaki_uzumaki.sh"
    "Lady Reze|/home/spectre/.config/rofi/scripts/lady_reze.sh"
)

# Build the list for Rofi
theme_list=""
for theme in "${THEMES[@]}"; do
    name="${theme%%|*}"
    theme_list="${theme_list}${name}\n"
done

# Remove trailing newline
theme_list="${theme_list%\\n}"

# Show Rofi menu and get selection
selected=$(echo -e "$theme_list" | rofi -dmenu \
    -p "Select Theme" \
    -i \
    -matching fuzzy \
    -no-custom)

# Exit if nothing selected
if [ -z "$selected" ]; then
    exit 0
fi

# Find and execute the corresponding script
for theme in "${THEMES[@]}"; do
    name="${theme%%|*}"
    script="${theme##*|}"
    
    if [ "$selected" = "$name" ]; then
        echo "Executing: $script"
        # Execute the script
        "$script" &
        exit 0
    fi
done

echo "Error: Script not found for '$selected'"
exit 1
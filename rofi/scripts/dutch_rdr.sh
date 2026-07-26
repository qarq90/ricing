#!/bin/bash

THEME_COLOR="FEAC01"
FONT_FAMILY="Chinese Rocks Rg"
FONT_SIZE="96"
FONT_LETTER_SPACING="32"

WALLPAPER="$HOME/.config/rofi/assets/dutch_rdr.png"

# Wallpaper
plasma-apply-wallpaperimage "$WALLPAPER"

QML_TIME="$HOME/.local/share/plasma/plasmoids/com.custom.tipu.data_time/contents/ui/main.qml"

# Color only
sed -Ei 's/color: "#?[0-9A-Fa-f]{6,8}"/color: "#'"$THEME_COLOR"'"/' "$QML_TIME"

QML_DAY="$HOME/.local/share/plasma/plasmoids/com.custom.tipu.day/contents/ui/main.qml"

# Color
sed -Ei 's/color: "#?[0-9A-Fa-f]{6,8}"/color: "#'"$THEME_COLOR"'"/' "$QML_DAY"

# Font family
sed -Ei 's/font\.family: ".*"/font.family: "'"$FONT_FAMILY"'"/' "$QML_DAY"

# Font letter spacing
sed -Ei 's/font\.letterSpacing: [0-9]+/font.letterSpacing: '"$FONT_LETTER_SPACING"'/' "$QML_DAY"

# Font size
sed -Ei 's/font\.pointSize: [0-9]+/font.pointSize: '"$FONT_SIZE"'/' "$QML_DAY"

# Update Cava
sed -Ei "s/foreground = \"#[0-9A-Fa-f]{6,8}\"/foreground = \"#$THEME_COLOR\"/" \
    "$HOME/.config/cava/config"

# Restart Plasma
kquitapp6 plasmashell 2>/dev/null
plasmashell >/dev/null 2>&1 &
disown
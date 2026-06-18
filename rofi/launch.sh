#!/bin/bash

# Check if rofi is already running
if pgrep -x "rofi" > /dev/null; then
    # If running, kill it (close it)
    pkill -x "rofi"
    exit 0
fi

# Launch rofi app launcher
rofi -show drun \

# Exit with rofi's exit code (0 if app selected, 1 if escaped/cancelled)
exit $?
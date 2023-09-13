#!/usr/bin/env bash

# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

# Run xidlehook
xidlehook \
    `# Don't lock when there's a fullscreen application` \
    --not-when-fullscreen \
    `# Don't lock when there's audio playing` \
    --not-when-audio \
    `# Dim the screen after 60 seconds, undim if user becomes active` \
    --timer 120 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness .1' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
    `# Undim & lock after 10 more seconds` \
    --timer 10 \
    'betterlockscreen -l dim' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
    `# Finally, suspend an hour after it locks` \
    --timer 300 \
    'systemctl suspend' \
    'openrgb -p sakura; xrandr --output "$PRIMARY_DISPLAY" --brightness 1'

# For external monitor
# export BRIGHTNESS_VALUE="$(ddcutil getvcp 10 | awk '/Brightness/{print $9}' | sed 's/,//g')"
# # Run xidlehook
# xidlehook \
#     `# Don't lock when there's a fullscreen application` \
#     --not-when-fullscreen \
#     `# Don't lock when there's audio playing` \
#     --not-when-audio \
#     `# Dim the screen after 60 seconds, undim if user becomes active` \
#     --timer 10 \
#     'ddcutil setvcp 10 0' \
#     'ddcutil setvcp 10 $BRIGHTNESS_VALUE --sleep-multiplier 1' \
#     `# Undim & lock after 10 more seconds` \
#     --timer 10 \
#     'betterlockscreen -l dim' \
#     'ddcutil setvcp 10 $BRIGHTNESS_VALUE --sleep-multiplier 1' \
#     `# Finally, suspend an hour after it locks`
#     --timer 10 \
#     'systemctl suspend' \
#     'ddcutil setvcp 10 $BRIGHTNESS_VALUE --sleep-multiplier 1; openrgb -p sakura'

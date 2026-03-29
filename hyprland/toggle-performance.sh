#!/usr/bin/env bash

# Disables animations, blur, rounding, shadows, transparency, and gaps

HYPRGAMEMODE=$(hyprctl getoption animations:enabled -j | jq -r '.int')

if [ "$HYPRGAMEMODE" = 1 ]; then
  hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword decoration:shadow:enabled 0;\
        keyword decoration:rounding 0;\
        keyword decoration:active_opacity 1.0;\
        keyword decoration:inactive_opacity 1.0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1" >/dev/null

  notify-send -t 2000 -a "Hyprland" "Performance Mode Enabled" "Disabled animations, blur, rounding, and transparency."
  echo "Performance mode ENABLED"
else
  # Reload config to restore normal settings
  hyprctl reload >/dev/null
  notify-send -t 2000 -a "Hyprland" "Performance Mode Disabled" "Restored normal appearance settings."
  echo "Performance mode DISABLED (config reloaded)"
fi

#!/bin/bash

# Created by Varrxy

# Volume increment/decrement amount
INCREMENT=5
SINK=@DEFAULT_SINK@

# Function to get the current volume of the sink
current_volume() {
    pactl get-sink-volume "$SINK" | awk '{print $5}' | sed 's/%//'
}

# Function to check if the sink is muted
current_mute() {
    pactl get-sink-mute "$SINK" | awk '{print $2}'
}

# Function to adjust the volume of the sink
adjust_volume() {
    local delta=$1
    local new_volume=$(( $(current_volume) + delta ))

    # Ensure volume is within the 0-100 range
    if [ "$new_volume" -gt 100 ]; then
        new_volume=100
    elif [ "$new_volume" -lt 0 ]; then
        new_volume=0
    fi

    pactl set-sink-volume "$SINK" "${new_volume}%"
}

# Main action based on the argument
case "$1" in
    --inc) adjust_volume "$INCREMENT" ;;
    --dec) adjust_volume -"$INCREMENT" ;;
    --toggle) pactl set-sink-mute "$SINK" "$( [ "$(current_mute)" = "yes" ] && echo 0 || echo 1 )" ;;
    *) 
        echo "Usage: $0 --inc | --dec | --toggle"
        exit 1 
        ;;
esac

#!/bin/bash

# Created by Varrxy

# Volume change amount
VOLUME_CHANGE=5

# Function to get the default audio source
get_default_source_name() {
    pactl info | grep 'Default Source:' | awk -F': ' '{print $2}'
}

# Get the default source name
SOURCE_NAME=$(get_default_source_name)

# Function to get current volume of the default source
current_source_volume() {
    pactl get-source-volume "$SOURCE_NAME" | awk '{print $5}' | sed 's/%//'
}

# Function to check current mute status of the default source
current_source_mute() {
    pactl get-source-mute "$SOURCE_NAME" | awk '{print $2}'
}

# Function to adjust the volume of the default source
adjust_source_volume() {
    local delta=$1
    local new_volume=$(( $(current_source_volume) + delta ))

    # Ensure volume is within the 0-100 range
    if [ "$new_volume" -gt 100 ]; then
        new_volume=100
    elif [ "$new_volume" -lt 0 ]; then
        new_volume=0
    fi

    pactl set-source-volume "$SOURCE_NAME" "${new_volume}%"
}

# Main action based on the argument
case "$1" in
    --inc) adjust_source_volume "$VOLUME_CHANGE" ;;
    --dec) adjust_source_volume -"$VOLUME_CHANGE" ;;
    --toggle) pactl set-source-mute "$SOURCE_NAME" "$( [ "$(current_source_mute)" = "yes" ] && echo 0 || echo 1 )" ;;
    *) 
        echo "Usage: $0 --inc | --dec | --toggle"
        exit 1 
        ;;
esac


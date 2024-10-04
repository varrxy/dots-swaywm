#!/bin/bash

# Set the directory containing your wallpapers
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Select a random wallpaper from the directory
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Catppuccin Darck color palette
COLOR_BG="#1e1e2f"          # Background color
COLOR_IN="#a0a1c0"          # Inside color
COLOR_RING="#c6a0f6"        # Ring color
COLOR_CLEAR_IN="#b5e3d8"    # Inside clear color
COLOR_CLEAR_RING="#6bd6c9"  # Ring clear color
COLOR_VER_IN="#b6c6ff"      # Inside verify color
COLOR_VER_RING="#9b6fdf"    # Ring verify color
COLOR_WRONG_IN="#ff3f3f"     # Inside wrong color
COLOR_WRONG_RING="#f14c4c"   # Ring wrong color

# Run swaylock with the desired options
swaylock --ignore-empty-password --show-failed-attempts \
    --color "$COLOR_BG" --inside-color "$COLOR_IN" --ring-color "$COLOR_RING" \
    --inside-clear-color "$COLOR_CLEAR_IN" --ring-clear-color "$COLOR_CLEAR_RING" \
    --inside-ver-color "$COLOR_VER_IN" --ring-ver-color "$COLOR_VER_RING" \
    --inside-wrong-color "$COLOR_WRONG_IN" --ring-wrong-color "$COLOR_WRONG_RING" \
    --image "$WALLPAPER"


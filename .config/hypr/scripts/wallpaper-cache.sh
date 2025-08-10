#!/bin/bash

cache_folder="$HOME/.cache/juan/hyprland-dotfiles"

generated_versions="$cache_folder/wallpaper-generated"

rm $generated_versions/*
echo ":: Wallpaper cache cleared"
notify-send "Wallpaper cache cleared"

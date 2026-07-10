#!/bin/bash

SOURCE="$1"
BACKGROUNDS="$HOME/Pictures/Backgrounds"

mkdir -p "$BACKGROUNDS"

BASENAME=$(basename "$SOURCE")
DEST_NAME="${BASENAME%.*}.png"
DEST="$BACKGROUNDS/$DEST_NAME"

magick "$SOURCE" "$DEST"

ln -sf "$DEST" "$BACKGROUNDS/current.png"

hyprctl hyprpaper preload "$DEST"
hyprctl hyprpaper wallpaper ",$DEST"

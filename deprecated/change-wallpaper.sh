#!/bin/sh
wall=$(find $HOME/Downloads/wallpapers/ -type f -name "*.jpg" -o -name "*.png" | shuf -n 1)
wal -c
wal -i $wall

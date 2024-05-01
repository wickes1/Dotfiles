#!/bin/bash

BASEDIR=$(dirname "$(realpath -e "$0")")

# Define arrays for source and target directories
source_dirs=(
    "$BASEDIR/dotfiles/awesome/rc.lua"
    "$BASEDIR/dotfiles/zsh/.zshrc"
)

target_dirs=(
    "$HOME/.config/awesome/rc.lua"
    "$HOME/.zshrc"
)

# Loop through each pair of source and target directories and run diff
for i in "${!source_dirs[@]}"; do
    echo "Diffing files in ${source_dirs[$i]} and ${target_dirs[$i]} ..."
    diff -r "${source_dirs[$i]}" "${target_dirs[$i]}"
    echo "--------------------------------------------------------------------"
done

#!/bin/bash

function dg() {
    datamodel-codegen --input "$1" --input-file-type "$2" --output "$3"
}

function set_brightness() {
    brightness=$1
    for display in $(xrandr --listmonitors | awk '{print $4}'); do
        xrandr --output "$display" --brightness "$brightness"
    done
}

function ya() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

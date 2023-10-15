brightness=$1
for display in $(xrandr --listmonitors | awk '{print $4}'); do
    xrandr --output "$display" --brightness "$brightness"
done

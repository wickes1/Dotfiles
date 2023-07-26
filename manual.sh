# Harddrive SMART
# https://wiki.archlinux.org/title/S.M.A.R.T.
sudo smartctl --info /dev/sda | grep 'SMART support is:'
sudo smartctl --smart=on /dev/sda
sudo smartctl -c /dev/sda
sudo smartctl -H /dev/sda

# TODO: SSD Trim
# https://wiki.archlinux.org/title/Solid_state_drive

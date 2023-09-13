### Install window manager and related tools ###

BASEDIR=$(dirname $(realpath -e $0))

# Display manager
yay -S --noconfirm \
    sddm \
    sddm-sugar-candy-git
sudo systemctl enable sddm.service
sudo rsync $BASEDIR/dotfiles/sddm.conf /etc/ -a

# Display server, windows manager and compositor
yay -S --noconfirm \
    xorg \
    awesome-git \
    picom-git
rsync $BASEDIR/dotfiles/awesome ~/.config -a
rsync $BASEDIR/dotfiles/picom ~/.config -a
rsync $BASEDIR/dotfiles/home/. ~ -a

# Application launcher
yay -S --noconfirm rofi
git clone --depth=1 https://github.com/adi1090x/rofi.git
cd rofi
chmod +x setup.sh
./setup.sh
cd ..
sudo rm -r rofi

# Power menu
yay -S --noconfirm archlinux-logout-git

# wallpaper
# yay -S --noconfirm feh
# git clone --depth 1 https://github.com/D3Ext/aesthetic-wallpapers.git ~/Pictures/aesthetic-wallpapers
yay -S --noconfirm variety

# screen locker
yay -S --noconfirm betterlockscreen xidlehook

# Screenlayout
rsync $BASEDIR/dotfiles/.screenlayout ~ -a

# Screenshot
yay -S --noconfirm flameshot
rsync -a ./dotfiles/flameshot/ ~/.config/flameshot

# Hide cursor
yay -S --noconfirm unclutter

# Keybinds
yay -S --noconfirm xbindkeys xkeyboard-config
rsync $BASEDIR/dotfiles/xbindkeys/. ~ -a

# OpenRGB
yay -S --noconfirm openrgb
rsync $BASEDIR/dotfiles/OpenRGB/. ~/.config/OpenRGB -a

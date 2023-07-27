# Setup display manager
yay -S --noconfirm \
    sddm \
    sddm-sugar-candy-git
sudo systemctl enable sddm.service
sudo cp ./dotfiles/sddm.conf.d /etc -r

# Setup display server and windows manager
yay -S --noconfirm \
    xorg \
    awesome-git
cp ./dotfiles/awesome ~/.config -r
cp ./dotfiles/home/. ~ -a

# Setup application launcher
yay -S --noconfirm rofi
git clone --depth=1 https://github.com/adi1090x/rofi.git
cd rofi
chmod +x setup.sh
./setup.sh
cd ..
sudo rm -r rofi

# Setup power menu
yay -S --noconfirm archlinux-logout-git

# Setup wallpaper
# yay -S --noconfirm feh
# git clone --depth 1 https://github.com/D3Ext/aesthetic-wallpapers.git ~/Pictures/aesthetic-wallpapers
yay -S --noconfirm variety

# Setup screen locker
yay -S --noconfirm \
    betterlockscreen \
    xidlehook

# Setup xorg compositor
yay -S --noconfirm picom-git
cp ./dotfiles/picom ~/.config/ -r

# Setup external monitor only
cp ./dotfiles/.screenlayout ~ -r

# Setup screenshot
yay -S --noconfirm flameshot

# Setup hide cursor
yay -S --noconfirm unclutter


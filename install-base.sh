### Base Linux packages installation ###

BASEDIR=$(dirname $(realpath -e $0))

# Fonts
yay -S --noconfirm \
    ttf-font-awesome \
    ttf-jetbrains-mono \
    ttf-jetbrains-mono-nerd \
    ttf-roboto \
    ttf-liberation \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji \
    noto-fonts-extra

# Shell
yay -S --noconfirm zsh zoxide
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git submodule add https://github.com/zdharma-continuum/fast-syntax-highlighting.git ./dotfiles/zsh-plugins/fast-syntax-highlighting
git submodule add https://github.com/zsh-users/zsh-autosuggestions ./dotfiles/zsh-plugins/zsh-autosuggestions
git submodule add https://github.com/qoomon/zsh-lazyload.git ./dotfiles/zsh-plugins/zsh-lazyload
rsync $BASEDIR/dotfiles/zsh/ ~ -a
rsync $BASEDIR/dotfiles/zsh-plugins/ $ZSH_CUSTOM/plugins/ -a --delete-after
rsync $BASEDIR/dotfiles/fsh ~/.config -a --delete-after
fast-theme XDG:catppuccin-macchiato

# Editors
yay -S --noconfirm neovim-nightly-bin neovide
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
rsync $BASEDIR/dotfiles/lvim ~/.config -a
# bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh)

# Terminal
# yay -S --noconfirm wezterm
# rsync ./dotfiles/wezterm ~/.config -a --delete-after
yay -S --noconfirm kitty
rsync $BASEDIR/dotfiles/kitty ~/.config -a --delete-after

# System backup
yay -S --noconfirm \
    timeshift \
    grub-btrfs \
    inotify-tools

# edit sudoers editor
sudo visudo
# Add line at the end:
# Defaults  env_keep += "SYSTEMD_EDITOR"

# edit grub-btrfsd.service for timeshift
sudo systemctl edit --full grub-btrfsd.service
# The line that contains:
# ExecStart=/usr/bin/grub-btrfsd /.snapshots --syslog
# Should be modified to read:
# ExecStart=/usr/bin/grub-btrfsd --syslog --timeshift-auto

sudo systemctl enable cronie.service --now
sudo systemctl enable grub-btrfsd.service --now

# System optimization
yay -S --noconfirm \
    preload \
    auto-cpufreq
sudo systemctl enable preload.service --now
sudo systemctl enable auto-cpufreq.service --now

# Set Linux use local time
timedatectl set-local-rtc 1 --adjust-system-clock

# Input method
yay -S --noconfirm \
    fcitx5-im \
    fcitx5-rime \
    fcitx5-material \
    fcitx5-material-color
rsync $BASEDIR/dotfiles/fcitx5 ~/.config -a

# Add rime in GUI
fcitx5-config-qt

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

# Install shell
yay -S --noconfirm \
    zsh \
    zoxide
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
cp ./dotfiles/zsh/.zshrc ~/.zshrc
cp ./dotfiles/zsh/.zshenv ~/.zshenv
cp ./dotfiles/zsh/dirhistory.plugin.zsh ~/.oh-my-zsh/plugins/dirhistory/dirhistory.plugin.zsh

# Editors
yay -S --noconfirm \
    neovim-nightly-bin \
    neovide
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh)
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
cp ./dotfiles/lvim ~/.config/ -r

# Terminal
yay -S --noconfirm wezterm
cp ./dotfiles/wezterm ~/.config/ -r

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

# GUI software
yay -S --noconfirm \
    arandr \
    google-chrome \
    thunar

# TUI software
yay -S --noconfirm \
    duf \
    duc \
    ncdu \
    difftastic \
    lsd \
    ripgrep \
    fd \
    sd \
    hyperfine \
    tokei \
    tealdeer \
    bandwhich \
    zoxide \
    grex \
    bottom \
    htop \
    procs \
    fnm \
    stacer \
    xplr \
    lf \
    xclock \
    inxi \
    xsel

tldr --update

# Install input method
yay -S --noconfirm \
    fcitx5-im \
    fcitx5-rime \
    fcitx5-material \
    fcitx5-material-color

cp ./dotfiles/fcitx5 ~/.config -r
# Add rime in GUI
fcitx5-config-qt

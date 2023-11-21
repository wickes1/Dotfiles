# Dotfiles

> This is the Dotfiles for personal usage.

The current setup is base on `arcolinuxb-xfce-v23.05.04-x86_64.iso`

Windows Manager: AwesomeWM
Shell: ZSH
Terminal: Kitty
Editor: Lunarvim
Theme: Catppuccin Macchiato

## Setup

- pluggable authentication modules(PAM)
- package manager
  - yay
- mirror list
  - reflector
  - reflector-simple
- locale
  - en_US.UTF-8 UTF-8
  - zh_CN.UTF-8 UTF-8
- polkit
  - xfce-polkit
- clipboard
  - xsel
  - copyq
  - flameshot
- font
  - font-manager
  - ttf-font-awesome
  - ttf-jetbrains-mono
  - ttf-jetbrains-mono-nerd
  - ttf-roboto
  - ttf-liberation
  - noto-fonts
  - noto-fonts-cjk
  - noto-fonts-emoji
  - noto-fonts-extra
  - <https://wiki.archlinux.org/title/Help:I18n>
- input method
  - fcitx5-im
  - fcitx5-rime
  - fcitx5-material-color
  - kill `ps -A | grep fcitx5 | awk '{print $1}'` && fcitx5 -d
  - <https://github.com/hosxy/Fcitx5-Material-Color>
- external monitor
  - arandr
- audio
  - pipewire (multimedia framework)
  - pipewire-audio (audio client)
  - pavucontrol (GUI controller)
  - wireplumber (session manager)
  - pacmixer
- driver
  - xf86-video-amdgpu
- display server
  - xorg
  - .xinitrc
  - .Xresources
- xorg automation
  - xdotool
  - autokey
- windows manager
  - awesomewm-git
  - twm
- terminal emulator
  - wezterm
- terminal multiplexers
  - zellij
- backlight
  - ddcui
  - brightnessctl
  - xfce4-power-manager
- shell
  - zsh
  - oh-my-zsh
    - theme: bira
    - plugins:
      - zsh-autosuggestions
      - z
  - <https://github.com/zsh-users/zsh-autosuggestions>
- editor
  - neovim
  - lunarvim
  - neovide
- status bar
  - polybar
- xorg compositor
  - picom-git
- application launcher
  - rofi
- display manager
  - sddm
  - xinit-xsession
- screenlocker
  - betterlockscreen
- notification daemon
  - naughty
  - dunst
- wallpaper
  - feh
  - python-pywal
- swapfile
  - no swap on installation
  - ext4 format
  - use swapfile on later stage
  - setup swap for hibernation
- bootloader
  - grub-install
- utility
  - duf(df alternative)
  - duc(du with graph)
  - ncdu(disk usage)
  - difftastic(diff alternative)
  - lsd(ls alternative)
  - ripgrep(grep alternative)
  - fd(find alternative)
  - sd(sed alternative)
  - hyperfine(shell benchmark)
  - tokei(code language statistics)
  - tealdeer(tldr)
  - bandwhich(network traffic monitor)
  - zoxide(zsh z alternative)
  - grex(regex generator)
  - bottom(resource monitor)
  - htop(process monitor)
  - procs(process monitor)
  - fnm(nvm alternative)
  - stacer(system cleaning)
  - thunar(file manager, gui)
  - xplr(file manager, rust tui)
  - lf(file manager, golang tui)
  - xclock(default boot program from xinit)
  - arandr(xrandr gui)
  - inxi(hardware overview)

## FAQ

- connect to wifi
  - nmcli device wifi connect <SSID> password <PW>
- show all os in grub
  - install `os-prober`, `update-grub`
  - `sudo os-prober`
  - `sudo update-grub`
- brightness control
  - internal monitor (e.g. laptop)
    - brightnessctl
  - external monitor
    - ddcutil
- laptop optimize
  - touchpad
    - natural scrolling
    - single tap
    - [libinput](https://wiki.archlinux.org/title/Libinput#Via_Xorg_configuration_file)

## Reference

[Best tool comparison](https://www.linuxlinks.com/ClipboardManagers/)<br>
[LunarVim configuration](https://www.lunarvim.org/docs/faq#how-do-i-use-lunarvim-in-neovide)<br>
[ZSH files](https://apple.stackexchange.com/questions/388622/zsh-zprofile-zshrc-zlogin-what-goes-where)<br>
[Vim Search](https://thevaluable.dev/vim-search-find-replace/)<br>
[AwesomeWM dotfiles](https://github.com/AlphaTechnolog/dotfiles)<br>
[AwesomeWM customization](http://epsi-rns.github.io/desktop/2019/06/15/awesome-overview.html)<br>
[Building Your Mouseless Development Environment](https://themouseless.dev/)<br>
[Code strcuture in lang](https://github.com/epsi-rns/case-examples)<br>
[ZSH keymap](https://thevaluable.dev/zsh-line-editor-configuration-mouseless/)<br>
[Lua 101](https://epsi.bitbucket.io/lambda/2020/11/16/playing-with-records-lua-01/)<br>
[Application list](https://wiki.archlinux.org/title/List_of_applications#top-page)<br>
[EWW powermenu](https://dharmx.is-a.dev/eww-powermenu/)<br>
[AwesomeWM example](https://github.com/muammar/awesome/blob/master/autostart.lua)<br>
<http://epsi-rns.github.io/desktop/2019/06/15/awesome-overview.html><br>

## Change default editor for sudo

<https://unix.stackexchange.com/questions/408413/change-default-editor-to-vim-for-sudo-systemctl-edit-unit-file>

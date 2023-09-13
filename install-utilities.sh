BASEDIR=$(dirname $(realpath -e $0))

# GUI software
yay -S --noconfirm \
    arandr \
    google-chrome \
    thunar \
    stacer

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
    xplr \
    lf \
    ueberzugpp \
    xclock \
    inxi \
    xsel \
    axel \
    entr \
    ani-cli-git \
    nvtop

tldr --update
rsync $BASEDIR/dotfiles/lf ~/.config/ -a
rsync $BASEDIR/dotfiles/ripgrep ~/.config/ -a

# Dev software
yay -S --noconfirm \
    dbeaver \
    visual-studio-code-bin \
    joplin-appimage

# Joplin CLI
NPM_CONFIG_PREFIX=~/.joplin-bin npm install -g joplin
sudo ln -s ~/.joplin-bin/bin/joplin /usr/bin/joplin
rsync $BASEDIR/dotfiles/joplin ~/.config/ -a

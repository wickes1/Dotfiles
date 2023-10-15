BASEDIR=$(dirname $(realpath -e $0))

# --delete-after will delete files that are not in the source directory after the sync

rsync $BASEDIR/dotfiles/awesome ~/.config -a --delete-after
rsync $BASEDIR/dotfiles/home/ ~ -a
rsync $BASEDIR/dotfiles/zsh/ ~ -a
rsync $BASEDIR/dotfiles/zsh-plugins/ ~/.oh-my-zsh/custom/plugins -a --delete-after
rsync $BASEDIR/dotfiles/kitty ~/.config -a --delete-after
rsync $BASEDIR/dotfiles/lvim ~/.config -a
rsync $BASEDIR/dotfiles/fsh ~/.config -a --delete-after
rsync $BASEDIR/dotfiles/lf ~/.config -a --delete-after
rsync $BASEDIR/dotfiles/scripts ~/.local/bin -a

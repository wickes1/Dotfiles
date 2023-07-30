BASEDIR=$(dirname $(realpath -e $0))

rsync $BASEDIR/dotfiles/awesome ~/.config -a --delete-after
rsync $BASEDIR/dotfiles/home/ ~ -a
rsync $BASEDIR/dotfiles/zsh/ ~ -a
rsync $BASEDIR/dotfiles/zsh-plugins/ ~/.oh-my-zsh/custom/plugins -a --delete-after 
rsync $BASEDIR/dotfiles/kitty ~/.config -a --delete-after
rsync $BASEDIR/dotfiles/lvim ~/.config -a

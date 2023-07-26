rsync ~/Dotfiles/dotfiles/awesome ~/.config -a --delete-after
rsync ~/Dotfiles/dotfiles/home/ ~ -a
rsync ~/Dotfiles/dotfiles/zsh/.zshrc ~/.zshrc
rsync ~/Dotfiles/dotfiles/zsh/.zshenv ~/.zshenv
rsync ~/Dotfiles/dotfiles/zsh/.scripts.sh ~/.scripts.sh
rsync ~/Dotfiles/dotfiles/kitty ~/.config -a --delete-after
rsync ~/Dotfiles/dotfiles/lvim ~/.config -a --delete-after


export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode auto # update automatically without asking
zstyle ':omz:update' frequency 14

ZSH_THEME="bira"
ENABLE_CORRECTION="false"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="false"
setopt hist_ignore_space

plugins=(
    sudo
    extract
    copybuffer
    copypath

    # custom plugins
    fast-syntax-highlighting
    zsh-autosuggestions
    zsh-lazyload # zsh-lazyload will execute command until it was called
    # zsh-defer # zsh-defer will execute command until zsh starup completed
    zsh-dirhistory
)

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8
export SYSTEMD_EDITOR="nvim"
export EDITOR="nvim"

# Aliases
alias envycontrol="curl -s https://raw.githubusercontent.com/bayasdev/envycontrol/main/envycontrol.py | sudo python -"
alias ll="lsd -lh"
alias c="copypath"
alias nv="$HOME/Dotfiles/lvim-gui.sh"
alias v="lvim ."
alias backup="rsync -a --delete-after ~/Dotfiles /run/media/$USER/Ventoy/"
alias restore="~/Dotfiles/restore-dotfiles.sh"
alias bk="backup; restore; echo 'Dotfiles backup and restored'"
alias wtr="curl -s wttr.in"

# Other
eval "$(zoxide init zsh)"
source "$HOME/.scripts.sh"
lazyload nvm -- 'source /usr/share/nvm/init-nvm.sh'

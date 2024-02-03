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
    # zsh-lazyload # zsh-lazyload will execute command until it was called
    # zsh-defer # zsh-defer will execute command until zsh starup completed
    zsh-dirhistory
)

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8
export SYSTEMD_EDITOR="nvim"
export EDITOR="lvim"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/.ripgreprc"

# Aliases
alias backup="rsync -a --delete-after ~/Dotfiles /run/media/$USER/Ventoy/"
alias bk="backup; restore; echo 'Dotfiles backup and restored'"
alias c="copypath"
alias envycontrol="curl -s https://raw.githubusercontent.com/bayasdev/envycontrol/main/envycontrol.py | sudo python -"
alias h='history'
alias lf='yazi'
alias ll="lsd -lh"
alias nv="~/Dotfiles/lvim-gui.sh"
alias restore="~/Dotfiles/restore-dotfiles.sh"
alias v="lvim ."
alias wtr="curl -s wttr.in"
alias fm="nohup thunar >/dev/null 2>&1 &"

# AWS
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/bin/aws_completer' aws

# Kitty
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# Other
eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd)"
source "$HOME/.scripts.sh"


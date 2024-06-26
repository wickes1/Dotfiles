export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode auto
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
    kubectl
    terraform
    npm

    # custom plugins
    fast-syntax-highlighting
    zsh-autosuggestions
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
alias envrestore="~/Dotfiles/restore-dotfiles.sh"
alias envdiff="~/Dotfiles/diff-dotfiles.sh"
alias v="lvim ."
alias wtr="curl -s wttr.in"
alias fm="nohup thunar >/dev/null 2>&1 & disown"
alias kapply="kustomize build . --enable-helm | kubectl apply -f -; [ -e charts ] && rm -r ./charts"
alias kdelete="kustomize build . --enable-helm | kubectl delete -f -; [ -e charts ] && rm -r ./charts"
alias kadd="kustomize edit add resource *.yaml"
alias vexample='yq -r "." secret.vault.yaml | jq -r "to_entries[] | \"\(.key): placeholder\"" > secret.example.yaml'
alias zj="zellij"

# AWS
# autoload bashcompinit && bashcompinit
# autoload -Uz compinit && compinit
# complete -C '/usr/bin/aws_completer' aws

# Kitty
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# Other
eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd)"
source "$HOME/.scripts.sh"


# Add bin-* directories to the PATH
for dir in $HOME/bin-*; do
    if [[ -d $dir ]]; then
        path+=("$dir")
    fi
done

export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

CASE_SENSITIVE="true"

plugins=(
    git
    jump
    extract
    sudo
    timer
    urltools
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

# ZSH
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

# GIT
alias amend='git commit -a --amend'
alias git_development='git checkout development'
alias git_staging='git checkout staging'
alias git_production='git checkout production'

# Python
alias python3='python'

# Jump
alias j='jump'

# NeoVim
alias v='nvim'

# Terraform
alias tf='terraform'

# NVM
source /usr/share/nvm/init-nvm.sh

# including this ensures that new gnome-terminal tabs keep the parent `pwd` !
if [ -e /etc/profile.d/vte.sh ]; then
    . /etc/profile.d/vte.sh
fi

alias gnome-open='xdg-open'


# Add bin-* directories to the PATH
dirs=($HOME/bin-*(/N))
for dir in $dirs; do
    path+=($dir)
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

# NVM
source /usr/share/nvm/init-nvm.sh

# including this ensures that new gnome-terminal tabs keep the parent `pwd` !
if [ -e /etc/profile.d/vte.sh ]; then
    . /etc/profile.d/vte.sh
fi

# Ruby
# export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
# path+=("$GEM_HOME/bin")
# eval "$(rbenv init - zsh)"

alias gnome-open='xdg-open'

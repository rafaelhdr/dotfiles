
# Add bin-* directories to the PATH.
# The (N/) qualifiers mean "no error if nothing matches" and "directories only",
# so a machine with no bin-* dir doesn't abort the rest of this file.
for dir in $HOME/bin-*(N/); do
    path+=("$dir")
done

export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

CASE_SENSITIVE="true"

plugins=(
    git
    gh
    jump
    extract
    sudo
    timer
    urltools
    archlinux
)

source $ZSH/oh-my-zsh.sh

# Show user@host in the prompt so it's clear which machine a terminal is on
PROMPT='%F{yellow}%n@%m%f '$PROMPT

# User configuration

export EDITOR='nvim'

# ZSH
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

# GIT
alias amend='git commit -a --amend'
alias git_development='git checkout development'
alias git_staging='git checkout staging'
alias git_production='git checkout production'

# Python
# Arch and friends ship 3.x as bare `python` with no `python3`; macOS is the
# opposite, so only bridge the gap when python3 is genuinely absent.
if ! command -v python3 >/dev/null 2>&1; then
    alias python3='python'
fi

# Jump
alias j='jump'

# NeoVim
alias v='nvim'

# Terraform
alias tf='terraform'

# Kubernetes homelab
export KUBECONFIG=~/.kube/homelab

# NVM
source /usr/share/nvm/init-nvm.sh

# including this ensures that new gnome-terminal tabs keep the parent `pwd` !
if [ -e /etc/profile.d/vte.sh ]; then
    . /etc/profile.d/vte.sh
fi

alias gnome-open='xdg-open'

# bit
case ":$PATH:" in
  *":/home/rafaelhdr/bin:"*) ;;
  *) export PATH="$PATH:/home/rafaelhdr/bin" ;;
esac
# bit end

. "$HOME/.local/bin/env"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/rafaelhdr/.lmstudio/bin"
# End of LM Studio CLI section

betterleaks() {
    mkdir -p "$PWD/.betterleaks-reports"
    docker run --rm \
        -w /repo \
        -v "$PWD":/repo:ro \
        -v "$PWD/.betterleaks-reports":/out \
    ghcr.io/betterleaks/betterleaks:latest "$@"
}

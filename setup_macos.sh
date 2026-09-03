#!/bin/bash
set -e

echo "Setting up for macOS..."

if ! command -v brew &> /dev/null; then
    echo "Homebrew not found, installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# The Homebrew installer does not touch the PATH of the shell that ran it, so
# load its environment here. Apple Silicon and Intel use different prefixes.
if ! command -v brew &> /dev/null; then
    for prefix in /opt/homebrew /usr/local; do
        if [ -x "$prefix/bin/brew" ]; then
            eval "$("$prefix/bin/brew" shellenv)"
            break
        fi
    done
fi

if ! command -v brew &> /dev/null; then
    echo "Homebrew is still not on the PATH, aborting."
    exit 1
fi

brew install $(cat packages_brew.txt)

# Homebrew's nvm is a plain script: it needs NVM_DIR to exist before the hook
# in .zshrc can source it.
mkdir -p ~/.nvm

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    # --unattended keeps the installer from launching zsh and swallowing the
    # rest of this script; setup.sh runs chsh afterwards.
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

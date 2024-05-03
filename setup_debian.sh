#!/bin/bash

echo "Setting up for Debian..."
sudo apt update
sudo apt install -y $(cat packages_common.txt)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

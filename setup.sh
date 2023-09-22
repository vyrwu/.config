#!/bin/bash

### TOOLS
brew upgrade
brew install --cask wezterm
brew install \
    nvim \
    ripgrep \
    lazygit \
    tmux \
    wget

### ZSH
tee -a $HOME/.zshrc << EOF
source $PWD/zsh/alias
export PATH=\$PATH:$HOME/.local/bin
EOF

### GIT
tee -a $HOME/.gitconfig << EOF
[include]
    path = $PWD/git/alias
EOF

wget -O $HOME/.local/bin/helm_ls https://github.com/mrjosh/helm-ls/releases/download/master/helm_ls_darwin_amd64 
chmod +x $HOME/.local/bin/helm_ls 

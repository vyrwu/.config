#!/bin/bash

### TOOLS
brew upgrade
brew install --cask wezterm
brew install \
    nvim \
    ripgrep \
    lazygit \
    tmux

### ZSH
tee -a $HOME/.zshrc << EOF
source $PWD/zsh/alias
EOF

### GIT
tee -a $HOME/.gitconfig << EOF
[include]
    path = $PWD/git/alias
EOF



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
ln -s $PWD/zsh/aliasrc ~/.aliasrc
tee -a $HOME/.zshrc << EOF
if [ -f ~/.aliasrc ]; then
  source $HOME/.aliasrc
fi
EOF

### GIT
tee -a $HOME/.gitconfig << EOF
[include]
    path = $PWD/git/alias
EOF



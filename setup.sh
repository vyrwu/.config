#!/bin/bash

### TOOLS
brew upgrade
brew install --cask wezterm
brew install \
    nvim \
    ripgrep \
    lazygit \
    tmux \
    wget \
    node \
    fsouza/prettierd/prettierd

mkdir "$HOME/.npm-global"
npm config set prefix "$HOME/.npm-global"

### ZSH
tee -a $HOME/.zshrc << EOF
source $PWD/zsh/alias
export PATH="\$PATH:$HOME/.local/bin"
export PATH="\$PATH:$HOME/.npm-global/bin"
export PATH="\$PATH:$HOME/go/bin"
EOF

### GIT
tee -a $HOME/.gitconfig << EOF
[include]
    path = $PWD/git/alias
EOF

wget -O $HOME/.local/bin/helm_ls https://github.com/mrjosh/helm-ls/releases/download/master/helm_ls_darwin_amd64
chmod +x $HOME/.local/bin/helm_ls

npm i -g vscode-langservers-extracted

go install github.com/katbyte/terrafmt@latest

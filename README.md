# .config
Collection of all my MacOS/Linux configuration files.

## Requirements

```bash
brew upgrade
brew install --cask wezterm
brew install \
    nvim \
    ripgrep \
    lazygit \
    tmux
ln -s ./zsh/aliasrc ~/.aliasrc
tee -a $HOME/.zshrc << EOF
if [ -f ~/.aliasrc ]; then
  source $HOME/.aliasrc
fi
EOF
```


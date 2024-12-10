# .config

Collection of all my MacOS/Linux configuration files.

## Initial installation

Requires a working [Nix](https://nixos.org/download/) installation.

```bash
make install
```

## Applying changes

```bash
make update
```

## TODO

- Load arbitrary programs into shell
- Improve fs navigation inside terminal
- Followup on managing WezTerm using Nix
- Switch between dark/light mode via keybinding
- Improve tmux session management and terminal window navigation
- Create keybindings for tree-sitter objects (functions/args/etc.)
- Find a way to follow up on industry news (newsboat)
- Automatically sync specific git repos (git-sync)
- Install Nix flake directly from GitHub
- Review oh my zsh plugins
- Check in my Oryx keyboard layout to Version Control
- Improve multi-machine Nix config management
- Manage dotfiles with Nix, not git repo
- Manage secrets and SSH keys with Nix // Inspiration:
  https://github.com/Baitinq/nixos-config

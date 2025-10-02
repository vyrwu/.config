# .config

Collection of all my MacOS/Linux configuration files.

### Requirements

- [Nix](https://nixos.org/download/)
- [Brew](https://brew.sh/)
- [TMP](https://github.com/tmux-plugins/tpm?tab=readme-ov-file#installation)

## TODO

- Remove reliance on Brew in favour of Nix
- Create keybindings for tree-sitter objects (functions/args/etc.)
- Introduce MINI plugins for better navigation.
- Automatically sync specific git repos (git-sync)
- Install Nix flake directly from GitHub
- Check in my Oryx keyboard layout to Version Control
- Store personal age key on Yubikey.
- Bootstrap script that does the following
  - Automatically install TMP upon new machine bootstrap.
  - Automatically install Nix and Brew.
  - Automatically generate machine's SSH key, and add it to sops/github.
- Activation script to set a pre-defined wallpapper
- Set default browser to Firefox

## Populate AWS Config with all available SSO accounts and roles

```
AWS_DEFAULT_SSO_START_URL=<AWS_SSO_START_URL> aws-sso-util configure populate --region <AWS_REGION>

```

# GEMINI.md: Project Context

This document provides a comprehensive overview of the `~/.config` directory, which contains a collection of personal configuration files (dotfiles) for setting up a development environment on macOS. The configuration is primarily managed using [Nix](https://nixos.org/), a powerful package manager and system configuration tool.

## Directory Overview

This directory is a classic "dotfiles" repository. It's not a traditional software project to be built and run, but rather a set of configuration files that define the user's development environment. The key technologies used are:

*   **Nix:** Used for declarative package management and system configuration. The core of the configuration is defined in `nix/flake.nix`.
*   **nix-darwin:** Allows for managing macOS configuration using Nix.
*   **Home Manager:** Manages a user's home directory configuration, including packages and dotfiles.
*   **Neovim:** The primary text editor, with a configuration written in Lua.
*   **Tmux:** A terminal multiplexer, configured in `tmux/tmux.conf`.
*   **Wezterm:** A terminal emulator, configured in `wezterm/wezterm.lua`.

## Key Files and Directories

*   `nix/flake.nix`: The entrypoint for the Nix configuration. It defines the dependencies (nixpkgs, nix-darwin, home-manager, etc.) and the system configurations.
*   `nix/modules/`: This directory contains the modularized Nix configuration for different aspects of the system, such as darwin settings, homebrew packages, and home-manager configuration.
*   `nix/modules/home-manager/home.nix`: This file declares the packages to be installed for the user.
*   `nvim/`: Contains the Neovim configuration, which is written in Lua.
    *   `nvim/init.lua`: The entrypoint for the Neovim configuration. It sets up the `lazy.nvim` plugin manager.
    *   `nvim/lua/plugins/`: This directory contains the configuration for all the Neovim plugins.
*   `tmux/tmux.conf`: The configuration file for the Tmux terminal multiplexer.
*   `wezterm/wezterm.lua`: The configuration file for the Wezterm terminal emulator.

## Building and Running

This is not a project that you "build" in a traditional sense. Instead, you apply the configuration to your system using Nix. The following commands are likely used to manage the environment:

*   `nix flake update`: Updates the dependencies of the flake.
*   `nix flake switch`: Applies the configuration to the system.

**TODO:** The exact commands for applying the configuration are not explicitly documented. It's recommended to add a `Makefile` or a script to simplify the process of updating and applying the configuration.

## Development Conventions

### Neovim Configuration

The Neovim configuration is well-structured and uses modern plugins:

*   **Plugin Manager:** `lazy.nvim` is used for managing plugins.
*   **LSP:** `nvim-lspconfig` is used for configuring language servers, providing features like auto-completion, go-to-definition, and diagnostics.
*   **Treesitter:** `nvim-treesitter` is used for syntax highlighting and code parsing.
*   **Fuzzy Finding:** `telescope.nvim` is used for finding files, searching for text, and more.
*   **Formatting:** `conform.nvim` is used for code formatting, with support for various formatters like `prettierd`, `stylua`, `ruff`, and `gofumpt`. Formatting is configured to run on save.
*   **Status Line:** `lualine.nvim` provides a configurable status line.

### Code Formatting

The `.prettierrc.json` and `.stylua.toml` files suggest a consistent code style is enforced for JavaScript, TypeScript, JSON, YAML, Markdown, and Lua. The Neovim configuration also enforces formatting for other languages like Python, Go, and Terraform.

{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "alek";
  home.homeDirectory = "/Users/alek";

  home.packages = [
    pkgs.git
    pkgs.neovim
    pkgs.ripgrep
    pkgs.lazygit
    pkgs.tmux
    pkgs.wget
    pkgs.kubectl
    pkgs.istioctl
    pkgs.gh
    pkgs.k9s
    # LANGUAGES
    pkgs.nodejs_22
    pkgs.go
    pkgs.terraform
    pkgs.python3
    # LANGUAGE SERVERS
    pkgs.helm-ls
    pkgs.vscode-langservers-extracted
    # FORMATTERS
    pkgs.nixfmt-rfc-style
    pkgs.textlint
    pkgs.textlint-rule-write-good
    pkgs.textlint-rule-common-misspellings
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh.shellAliases = {
    tf = "terraform";
    tfws = "terraform workspace select";
    tffv = "terraform fmt --recursive && tf validate";
    python = "python3";
    k = "kubectl";
    kcvm = "kubectl config view --minify | grep current";
    kcuc = "kubectl config use-context";
    i = "istioctl";
    k9h = "k9s --headless";
    ghpr = "gh pr create --fill";
  };

  programs.zsh.initExtra = ''
    # SYSTEM PATH
    export PATH="$PATH:$HOME/.config/bin"
    export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"

    # ENVIRONMENT VARIABLES
    export PRETTIERD_DEFAULT_CONFIG="$HOME/.config/.prettierrc.json"
    export DVY="$HOME/code/github/alek"
    export GVY="https://github.com/alek"
  '';

  programs.git.aliases = {
    co = "checkout";
    st = "status";
  };

  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.plugins = [ "git" ];
  programs.zsh.oh-my-zsh.theme = "agnoster";
}

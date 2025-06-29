{ config, ... }:
{
  programs.zsh.enable = true;
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
    ### PATH
    # Disables builtin Python in favour of Nix-managed one.
    export PATH=$(echo $PATH | sed -r 's|/Library/Frameworks/Python.framework/Versions/3.11/bin:||')
    export PATH=$(echo $PATH | sed -r 's|/Library/Frameworks/Python.framework/Versions/3.10/bin:||')
    # Prioritise Nix binaries over Homebrew, until it is removed all together.
    export PATH=$(echo $PATH | sed -r "s|(/opt/homebrew/bin)(:)(.*)|\3\2\1|")
    export PATH=$(echo $PATH | sed -r "s|(/opt/homebrew/sbin)(:)(.*)|\3\2\1|")
    export PATH="$PATH:$HOME/.config/scripts"

    ### SHELL VARIABLES
    export EDITOR="nvim";
    export PRETTIERD_DEFAULT_CONFIG="$HOME/.config/.prettierrc.json";
    export XMLFORMAT_CONF="$HOME/.config/.xmlformat.conf";
    export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt";
    export AVANTE_GEMINI_API_KEY="$(cat ${config.sops.secrets.avante_gemini_api_key.path})";

  '';
  programs.zsh.autosuggestion.enable = true;

  programs.git.aliases = {
    co = "checkout";
    st = "status";
  };

  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.plugins = [ "git" ];
  programs.zsh.oh-my-zsh.theme = "agnoster";

  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;
}

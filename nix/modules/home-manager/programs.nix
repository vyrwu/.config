{ ... }:
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
    # SYSTEM PATH
    # Disables builtin Python.
    export PATH=$(echo $PATH | sed -r 's|/Library/Frameworks/Python.framework/Versions/3.11/bin:||')
    export PATH=$(echo $PATH | sed -r 's|/Library/Frameworks/Python.framework/Versions/3.10/bin:||')
    # FIXME: Prioritise Nix binaries over Homebrew, until it is removed all together.
    export PATH=$(echo $PATH | sed -r "s|(/opt/homebrew/bin)(:)(.*)|\3\2\1|")
    export PATH=$(echo $PATH | sed -r "s|(/opt/homebrew/sbin)(:)(.*)|\3\2\1|")
    export PATH="$PATH:$HOME/.config/scripts"

    export EDITOR="nvim"
    # ENVIRONMENT VARIABLES
    export PRETTIERD_DEFAULT_CONFIG="$HOME/.config/.prettierrc.json"
    export XMLFORMAT_CONF="$HOME/.config/.xmlformat.conf"

    # TODO: store the key in an encrypted form.
    # Inspiration: https://github.com/ryantm/agenix
    export ANTHROPIC_API_KEY="unset"
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

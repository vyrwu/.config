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
    cd = "z";
    cat = "bat --paging=never";
    ls = "lla --sort size -T";
  };
  programs.zsh.initExtra = ''
    ### PATH
    export PATH="$PATH:$HOME/.local/bin"
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
    export ATMOS_COMPONENTS_TERRAFORM_COMMAND="tofu"

    export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt";
    export GEMINI_API_KEY="$(cat ${config.sops.secrets.gemini_api_key.path})";
    export GOOGLE_SEARCH_API_KEY="$(cat ${config.sops.secrets.google_search_api_key.path})";
    export GOOGLE_SEARCH_ENGINE_ID="$(cat ${config.sops.secrets.google_search_engine_id.path})";
    export GH_TOKEN="$(cat ${config.sops.secrets.gh_token.path})"


    # Alias for aws-vault to automatically update kubeconfig on login
    alias av='_aws_vault_kube_exec'

    _aws_vault_kube_exec() {
      if [ -z "$1" ]; then
        echo "Usage: av <profile-name>"
        aws-vault list
        return 1
      fi
      
      # The AWS_VAULT variable is set by the aws-vault process itself.
      # We pass it as an argument to our hook script.
      aws-vault exec "$1" -- ~/.config/scripts/aws-vault-kube-hook/aws-vault-kube-hook "$1"
    }

    # Zoxide config
    export _ZO_DATA_DIR="$HOME/.config/zoxide"
    eval "$(zoxide init zsh)"
  '';
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.enableCompletion = true;

  programs.git = {
    enable = true;

    aliases = {
      co = "checkout";
      st = "status";
    };

    userEmail = "dev.anowak@gmail.com";
    userName = "vyrwu";

    extraConfig = {
      url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };

  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.plugins = [ "git" ];
  programs.zsh.oh-my-zsh.theme = "agnoster";

  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;
}

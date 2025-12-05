{ pkgs, ... }:
let
  packages = {
    desktop = [
      pkgs.aerospace
      pkgs.gimp
      pkgs.slack
      pkgs.firefox
      pkgs.notion-app
    ];

    cli = [
      pkgs.neovim
      pkgs.ripgrep
      pkgs.tmux
      pkgs.wget
      pkgs.parallel
      pkgs.just
      pkgs.pre-commit
      pkgs.copier
      pkgs.texliveFull
      pkgs.textlint
      pkgs.textlint-rule-write-good
      pkgs.textlint-rule-common-misspellings
      pkgs.xmlformat
      pkgs.codespell
      pkgs.openapi-generator-cli
      pkgs.redis
      pkgs.newsboat
      pkgs.lazysql
      pkgs.pritunl-client
      pkgs.wezterm
      pkgs.zoxide
      pkgs.fzf
      pkgs.bat
      pkgs.lla
    ];

    ai = [
      pkgs.gemini-cli
      pkgs.claude-code
    ];

    aws = [
      pkgs.awscli2
      pkgs.aws-vault
      pkgs.aws-sso-util
    ];

    gcp = [
      pkgs.google-cloud-sdk
    ];

    encryption = [
      pkgs.sops
      pkgs.yubikey-manager
      pkgs.age
      pkgs.age-plugin-yubikey
    ];

    docker = [
      pkgs.colima
      pkgs.docker-credential-helpers
      pkgs.docker
      pkgs.docker-buildx
      pkgs.lazydocker
    ];

    kubernetes = [
      pkgs.kubebuilder
      pkgs.kubectl
      pkgs.istioctl
      pkgs.k9s
      (pkgs.wrapHelm pkgs.kubernetes-helm { plugins = [ pkgs.kubernetes-helmPlugins.helm-diff ]; })
      pkgs.helm-ls
      pkgs.helmfile
      pkgs.kustomize
      pkgs.eks-node-viewer
      pkgs.kind
      pkgs.eksctl
      pkgs.kubent
      pkgs.kubeconform
    ];

    go = [
      pkgs.go
      pkgs.gopls
      pkgs.air
      pkgs.go-swag
      pkgs.compile-daemon
      pkgs.govulncheck
      pkgs.go-mockery
      pkgs.golangci-lint
      pkgs.gofumpt
      pkgs.goimports-reviser
      pkgs.golines
      pkgs.templ
      pkgs.htmx-lsp
      pkgs.gotools
      pkgs.delve
    ];

    python = [
      pkgs.python313
      pkgs.python313Packages.pip
      pkgs.virtualenv
      pkgs.poetry
      pkgs.pyright
      pkgs.mypy
      pkgs.rye
      pkgs.ruff
      pkgs.uv
    ];

    js = [
      pkgs.nodejs_22
      pkgs.bun
      pkgs.vscode-langservers-extracted
      pkgs.nodePackages.typescript-language-server
      pkgs.eslint_d
      pkgs.prettierd
      pkgs.esbuild
      pkgs.yarn
    ];

    nix = [
      pkgs.nix-search-cli
      pkgs.nil
      pkgs.nixfmt-rfc-style
    ];

    tailwindcss = [
      pkgs.tailwindcss
      pkgs.tailwindcss-language-server
    ];

    iac = [
      pkgs.terraform
      pkgs.terraform-ls
      pkgs.tflint
      pkgs.opentofu
      pkgs.atmos
    ];

    lua = [
      pkgs.lua-language-server
      pkgs.stylua
    ];

    bash = [
      pkgs.bash-language-server
      pkgs.shfmt
    ];

    yaml = [
      pkgs.yq-go
      pkgs.yaml-language-server
      pkgs.yamllint
    ];

    git = [
      pkgs.git
      pkgs.lazygit
    ];

    github = [
      pkgs.act
      pkgs.actionlint
      pkgs.gh
    ];

    csharp = [
      pkgs.dotnet-sdk_9
      pkgs.csharpier
      pkgs.omnisharp-roslyn
    ];
  };

  flattenPackages = builtins.foldl' (acc: kind: acc ++ packages.${kind}) [ ] (
    builtins.attrNames packages
  );
in
{
  home.packages = flattenPackages;
}

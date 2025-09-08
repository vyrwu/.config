{ pkgs, ... }:
let
  packages = {
    desktop = [
      pkgs.aerospace
      pkgs.gimp
      pkgs.slack
    ];

    cli = [
      pkgs.neovim
      pkgs.ripgrep
      pkgs.tmux
      pkgs.wget
      pkgs.parallel
      pkgs.just
      pkgs.aws-vault
      pkgs.pre-commit
      pkgs.copier
      # pkgs.texliveFull
      pkgs.textlint
      pkgs.textlint-rule-write-good
      pkgs.textlint-rule-common-misspellings
      pkgs.xmlformat
      pkgs.codespell
      pkgs.openapi-generator-cli
      pkgs.redis
      pkgs.age
      pkgs.sops
      pkgs.newsboat
      pkgs.lazysql
      pkgs.pritunl-client
      pkgs.gemini-cli
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
      pkgs.kubernetes-helm
      pkgs.helm-ls
      pkgs.helmfile
      pkgs.kustomize
      pkgs.eks-node-viewer
      pkgs.kind
      pkgs.eksctl
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

    terraform = [
      pkgs.terraform
      pkgs.terraform-ls
      pkgs.tflint
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

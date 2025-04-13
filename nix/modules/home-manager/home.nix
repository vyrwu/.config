{ pkgs, ... }:
let
  packages = {
    desktop = [
      pkgs.aerospace
      pkgs.jankyborders
      pkgs.gimp
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
    ];

    docker = [
      pkgs.colima
      pkgs.docker-credential-helpers
      pkgs.docker
      pkgs.docker-buildx
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
    ];

    python = [
      pkgs.python312
      pkgs.python312Packages.pip
      pkgs.virtualenv
      pkgs.poetry
      pkgs.pyright
      pkgs.mypy
      pkgs.black
      pkgs.isort
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
      pkgs.actionlint # GitHub Actions only
    ];

    git = [
      pkgs.git
      pkgs.lazygit
      pkgs.gh # GtiHub only
    ];
  };

  flattenPackages = builtins.foldl' (acc: kind: acc ++ packages.${kind}) [ ] (
    builtins.attrNames packages
  );
in
{
  home.packages = flattenPackages;
}

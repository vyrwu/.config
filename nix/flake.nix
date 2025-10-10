{
  description = "My nix-darwin config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default-darwin";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      systems,
      sops-nix,
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // nix-darwin.lib;

      pkgsFor = lib.genAttrs (import systems) (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );

      sharedModules = [
        ./modules/nix.nix
        ./modules/darwin.nix
        ./modules/homebrew.nix
        inputs.home-manager.darwinModules.home-manager
        ./modules/home-manager
      ];
    in
    {
      inherit lib;

      # FIXME: Improve hostnames for my machines
      darwinConfigurations = {
        "Aleksanders-MacBook" = lib.darwinSystem {
          pkgs = pkgsFor.aarch64-darwin;
          modules = [
            ./modules/hosts/macbook-zn.nix
          ]
          ++ sharedModules;
          specialArgs = {
            inherit self inputs outputs;
            # FIXME: This should rather be computed based on hostnames.
            username = "aleksandernowak";
          };
        };
        "Aleksanders-MacBook-Pro" = lib.darwinSystem {
          pkgs = pkgsFor.aarch64-darwin;
          modules = [
            ./modules/hosts/macbook-wawa.nix
          ]
          ++ sharedModules;
          specialArgs = {
            inherit self inputs outputs;
            # FIXME: This should rather be computed based on hostnames.
            username = "aleksandernowak";
          };
        };
        "Aleks-MacBook-Pro" = lib.darwinSystem {
          pkgs = pkgsFor.x86_64-darwin;
          modules = [
            ./modules/hosts/macbook-personal.nix
          ]
          ++ sharedModules;
          specialArgs = {
            inherit self inputs outputs;
            # FIXME: This should rather be computed based on hostnames.
            username = "alek";
          };
        };
      };
    };
}

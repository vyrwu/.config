{
  description = "My nix-darwin config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    systems.url = "github:nix-systems/default-darwin";
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      systems,
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
    in
    {
      inherit lib;

      # FIXME: Improve hostnames for my machines
      darwinConfigurations = {
        "Aleksanders-MacBook" = lib.darwinSystem {
          pkgs = pkgsFor.aarch64-darwin;
          modules = [
            ./modules/nix.nix
            ./modules/darwin.nix
            ./modules/homebrew.nix
            ./modules/hosts/macbook-zn.nix
            home-manager.darwinModules.home-manager
            ./modules/home-manager
          ];
          specialArgs = {
            inherit self inputs outputs;
            # FIXME: This should rather be computed based on hostnames.
            username = "aleksandernowak";
          };
        };
        "Aleks-MacBook-Pro" = lib.darwinSystem {
          pkgs = pkgsFor.x86_64-darwin;
          modules = [
            ./modules/nix.nix
            ./modules/darwin.nix
            ./modules/homebrew.nix
            ./modules/hosts/macbook-personal.nix
            home-manager.darwinModules.home-manager
            ./modules/home-manager
          ];
          specialArgs = {
            inherit self inputs outputs;
            # FIXME: This should rather be computed based on hostnames.
            username = "alek";
          };
        };
      };
    };
}

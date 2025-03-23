{ pkgs, ... }:
{
  # Auto upgrade nix package and the daemon service.
  nix.package = pkgs.nix;

  nix.settings.experimental-features = "nix-command flakes";

  nix.optimise.automatic = true;

  nixpkgs = {
    config.allowUnfree = true;
  };
}

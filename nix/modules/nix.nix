{ pkgs, ... }:
{
  # Auto upgrade nix package and the daemon service.
  nix.package = pkgs.nix;

  nix.settings.experimental-features = "nix-command flakes";

  # Increase download buffer to overcome warnings:
  # ref: https://github.com/NixOS/nix/issues/11728
  nix.settings.download-buffer-size = 524288000;

  nix.optimise.automatic = true;

  nixpkgs = {
    config.allowUnfree = true;
  };
}

{
  username,
  pkgs,
  inputs,
  ...
}:
{
  home-manager.backupFileExtension = "backup";
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${username} = {
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
    home.username = "${username}";
    home.homeDirectory = "/Users/${username}";

    imports = [
      (import ./home.nix { inherit pkgs; })
      ./programs.nix
      (import ./sops { inherit inputs username; })
    ];
  };
}

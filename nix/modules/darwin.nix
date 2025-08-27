{
  pkgs,
  self,
  username,
  ...
}:
{
  system.configurationRevision = self.rev or self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  programs.zsh.enable = true; # default shell on catalina
  ### OWN CONFIG

  environment.systemPackages = [
    pkgs.vim
  ];
  environment.shells = [
    pkgs.bashInteractive
    pkgs.zsh
  ];

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.hack-font
  ];

  system.defaults.NSGlobalDomain.KeyRepeat = 3;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain."com.apple.trackpad.scaling" = 3.0;
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;
  system.defaults.WindowManager.AutoHide = true;

  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.expose-group-apps = true;

  system.defaults.spaces.spans-displays = true;

  system.defaults.finder.CreateDesktop = false;
  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder.ShowStatusBar = true;
  system.defaults.finder._FXShowPosixPathInTitle = true;
  system.defaults.finder._FXSortFoldersFirst = true;

  system.defaults.loginwindow.autoLoginUser = "${username}";

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
  };

  system.primaryUser = "${username}";
}

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

  system.defaults.NSGlobalDomain.KeyRepeat = 2;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain."com.apple.trackpad.scaling" = 3.0;

  system.defaults.dock.autohide = true;
  system.defaults.dock.expose-animation-duration = 1.0;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.expose-group-apps = true;

  system.defaults.spaces.spans-displays = true;

  system.defaults.finder.CreateDesktop = false;
  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder.ShowStatusBar = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;
  # TODO: the following option is broken:
  # system.defaults.universalaccess.reduceMotion = 1;
  # system.defaults.universalaccess.reduceTransparency = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
  };

  system.primaryUser = "${username}";
}

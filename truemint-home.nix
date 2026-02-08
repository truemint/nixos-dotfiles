{ config, pkgs, ... }:

{
  home.username = "truemint";
  home.homeDirectory = "/home/truemint";
  home.stateVersion = "25.11";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo Hello truemint";
    };

  };
}

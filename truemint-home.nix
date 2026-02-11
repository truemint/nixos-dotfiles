{ config, pkgs, ... }:

{
  home = {
    username = "truemint";
    preferXdgDirectories = true;
    homeDirectory = "/home/truemint";
    stateVersion = "25.11";
  };
  
  programs = {
    kitty.enable = true;
  };

  # xdg.enable = true tells home-manager to create environment variables for 
  # XDG_CONFIG_HOME and other related directories as per the XDG Base Directory Specification
  # https://specifications.freedesktop.org/basedir/latest/
  xdg.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, Q, exec, kitty"
	"$mod, C, killactive,"
	"$mod, M, exit,"
      ];
    };
  };
  catppuccin = {
    flavor = "mocha";
    hyprland.enable = true;
    kitty.enable = true;
  };
}

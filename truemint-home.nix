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
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        # exec uwsm start -S hyprland-uwsm.desktop
	exec hyprland
      fi
    '';
  };
}

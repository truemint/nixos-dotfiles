# Nix config for Hyprland window tiling manager

{ config, lib, pkgs, flakeInputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, Q, exec, ghostty"
	"$mod, C, killactive,"
	"$mod, M, exit,"
      ];
    };
  };

  catppuccin.hyprland.enable = true;
}

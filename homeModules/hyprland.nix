# Nix config for Hyprland window tiling manager

{ config, lib, pkgs, flakeInputs, ... }:
{
  programs.kitty.enable = false;

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

  catppuccin = {
    hyprland.enable = true;
    # kitty.enable = true;
    ghostty.enable = true;
  };
}

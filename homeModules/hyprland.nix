# Nix config for Hyprland window tiling manager

{ config, lib, pkgs, flakeInputs, ... }:
{
  programs.kitty.enable = true;

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
    hyprland.enable = true;
    kitty.enable = true;
  }
}

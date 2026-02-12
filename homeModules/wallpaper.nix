# Truemint's wallpaper configuration

{ config, pkgs, lib, ... }:

{
  services.wpaperd = {
    enable = true;
    settings.default = {
      path = "~/Downloads/Wallpapers";
      duration = "30m";
      sorting = "random";
      mode = "center";
    };
  };
}

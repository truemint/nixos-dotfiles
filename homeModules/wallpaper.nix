# Truemint's wallpaper configuration

{ config, pkgs, lib, ... }:

{
  services.wpaperd = {
    enable = true;
    settings = {
      path = "~/Downloads/Wallpapers";
      duration = "10s";
      sorting = "random";
      mode = "center";
    };
  };
}

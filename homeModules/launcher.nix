# App launcher config (rofi, wofi, tofi, etc.)
{ config, pkgs, lib, ... }: {
  programs.rofi = {
    enable = true;
    modes = [ "drun" "run" "calc" ];
    plugins = [ pkgs.rofi-calc ];
  };
}

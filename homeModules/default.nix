{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./launcher.nix
    ./hyprland.nix
    ./terminal.nix
    ./wallpaper.nix
    ./git.nix
  ];
}

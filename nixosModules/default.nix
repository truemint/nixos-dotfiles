{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./boot.nix
    ./linux-swap.nix
    ./login.nix
    ./home-manager.nix
    ./fonts.nix
    ./hardware
    ./programs
  ];
}

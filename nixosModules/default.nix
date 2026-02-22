{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./boot.nix
    ./linux-swap.nix
    ./nvidia.nix
    ./login.nix
    ./home-manager.nix
    ./fonts.nix
    ./programs.nix
  ];
}

{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./boot.nix
    ./nvidia.nix
    ./login.nix
    ./home-manager.nix
    ./fonts.nix
  ];
}

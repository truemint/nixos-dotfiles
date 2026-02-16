{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./home-manager.nix
    ./fonts.nix
  ];
}

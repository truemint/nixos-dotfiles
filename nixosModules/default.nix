{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./login.nix
    ./home-manager.nix
    ./fonts.nix
  ];
}

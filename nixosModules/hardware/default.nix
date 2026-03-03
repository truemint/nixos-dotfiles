{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./graphics.nix
    ./audio.nix
  ];
}

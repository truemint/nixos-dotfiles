{
  config,
  pkgs,
  flakeInputs,
  ...
}: {
  home.packages = [flakeInputs.opencode.packages.${pkgs.system}.default];
}

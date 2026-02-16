# Home Manager config
{
  config,
  lib,
  pkgs,
  flakeInputs,
  ...
}: {
  imports = [
    flakeInputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    # useUserPackages = true;
    backupFileExtension = "backup";
    users = {
      truemint = {
        imports = [
          ../truemint-home.nix
        ];
      };
    };
  };
}

# Home Manager config
{
  flakeInputs,
  myConfig,
  ...
}: {
  imports = [flakeInputs.home-manager.nixosModules.home-manager];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit flakeInputs myConfig;};
    users = {
      "${myConfig.userName}" = {
        imports = [
          ../truemint-home.nix
        ];
      };
    };
  };
}

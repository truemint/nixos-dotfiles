{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";		# Ensures that home-manager version is in sync with nixpkgs version
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations.Truemint-NixOS = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./configuration.nix
	home-manager.nixosModules.home-manager
	{
	  home-manager = {
            useGlobalPkgs = true;
	    useUserPackages = true;
	    backupFileExtension = "backup";
	    users.truemint = import ./truemint-home.nix;
	  };
	}
      ];
    };
  };
}

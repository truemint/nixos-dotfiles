{
  description = "A very basic flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    catppuccin.url = "github:catppuccin/nix/release-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";	# Ensures that packages used by home-manager come from the same nixpkgs version as that used by our flake
    };
  };

  outputs = { nixpkgs, ... } @ flakeInputs: 
    let
      system = "x86_64-linux";
    in {
    nixosConfigurations.Truemint-NixOS = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit flakeInputs system; };
      modules = [ 
        ./configuration.nix
      ];
    };
  };
}

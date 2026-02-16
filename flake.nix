{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    catppuccin.url = "github:catppuccin/nix/release-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs"; # Ensures that packages used by home-manager come from the same nixpkgs version as that used by our flake
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ flakeInputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    formatter.${system} = pkgs.alejandra;
    nixosConfigurations.Truemint-NixOS = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit flakeInputs system;};
      modules = [
        ./hosts/nixos/configuration.nix
      ];
    };
  };
}

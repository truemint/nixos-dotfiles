{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.Truemint-NixOS = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration.nix ];
    };
  };
}

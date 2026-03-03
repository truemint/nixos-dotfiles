{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";

      # Ensure that packages used by home-manager come from the same nixpkgs version as that used by our flake
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    catppuccin.url = "github:catppuccin/nix/release-25.11";
    vicinae.url = "github:vicinaehq/vicinae";
  };

  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://vicinae.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };

  outputs = {nixpkgs, ...} @ flakeInputs: let
    system = "x86_64-linux";
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    nixosConfigurations.Truemint-NixOS = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit flakeInputs system;};
      modules = [./hosts/nixos/configuration.nix];
    };
  };
}

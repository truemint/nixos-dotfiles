# System level configuration for Hyprland
# Full configuration is available as a home-manager module
# A system level config is needed to enable UWSM
{
  config,
  pkgs,
  flakeInputs,
  ...
}: {
  # Setup Hyprland as the window tiling manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

    # Set the flake package
    package = flakeInputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    # Set the portal package from the same flake so that they are in sync
    portalPackage = flakeInputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    # Run Hyprland with UWSM for session management
    withUWSM = true;
  };

  # Portals (screen share, file pickers, etc.)
  # Hyprland module enables xdg-desktop-portal-hyprland; adding GTK portal is commonly recommended.
  # Reference: https://wiki.hypr.land/Hypr-Ecosystem/xdg-desktop-portal-hyprland/
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}

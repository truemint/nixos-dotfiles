# Programs to install system-wide
{
  config,
  pkgs,
  flakeInputs,
  ...
}: {
  # Set up ZSH as the default shell for all users
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Facilitate ZSH syntax completion for system commands
  # Reference: http://www.mynixos.com/home-manager/option/programs.zsh.enableCompletion
  environment.pathsToLink = ["/share/zsh"];

  # Set up system tools
  environment.systemPackages = with pkgs; [
    wget
    btop
    git
    bat
    tree
  ];

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

  # Set up Neovim as an editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}

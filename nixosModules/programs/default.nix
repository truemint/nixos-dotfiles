# Programs to install system-wide
{
  config,
  pkgs,
  flakeInputs,
  ...
}: {
  # Import individual modules
  imports = [
    ./hyprland.nix
    ./zsh.nix
  ];

  # Set up system tools
  environment.systemPackages = with pkgs; [
    wget
    btop
    git
    bat
    tree
  ];

  # Set up Neovim as an editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}

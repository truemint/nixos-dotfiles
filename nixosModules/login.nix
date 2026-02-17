# Login manager configuration
{
  config,
  pkgs,
  ...
}: {
  services.displayManager = {
    enable = true;
    defaultSession = "hyprland";
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm; # Install the qt6 SDDM version
      extraPackages = [
        pkgs.sddm-astronaut
      ];
      theme = "sddm-astronaut-theme";
      #theme = "where-is-my-sddm-theme";
    };
  };
  environment.systemPackages = [pkgs.sddm-astronaut];
}

# Configuration specific to Nvidia GPU
{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement.enable = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = true;
    };
  };

  # Load nvidia drivers early to fix resolution issues with boot screens
  boot = {
    initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    extraModulePackages = [config.boot.kernelPackages.nvidiaPackages.stable];
  };
}

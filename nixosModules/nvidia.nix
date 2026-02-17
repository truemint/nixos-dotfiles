# Configuration specific to Nvidia GPU
{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  # The names of the video drivers the configuration supports.
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    # Whether to enable hardware accelerated graphics drivers
    graphics.enable = true;

    nvidia = {
      # Whether to enable kernel modesetting when using the NVIDIA proprietary driver
      modesetting.enable = true;

      # Whether to enable nvidia-settings, NVIDIA's GUI configuration tool.
      nvidiaSettings = true;

      # Whether to enable experimental power management through systemd
      powerManagement.enable = false;

      # The NVIDIA driver package to use
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      # Whether to enable the open source NVIDIA kernel module
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

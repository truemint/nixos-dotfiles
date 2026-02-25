# Graphics config
# Multi-GPU: https://wiki.hypr.land/0.52.0/Configuring/Multi-GPU/
{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  # The names of the video drivers the configuration supports.
  services.xserver.videoDrivers = ["amdgpu" "nvidia"];

  hardware = {
    graphics = {
      # Enable hardware accelerated graphics drivers
      enable = true;

      # Also install 32-bit drivers for 32-bit applications (such as Wine)
      enable32Bit = true;
    };

    amdgpu = {
      # Enable loading amdgpu kernel module in stage 1.
      # This helps with low resolution issues during early boot phases.
      initrd.enable = true;
    };

    nvidia = {
      # Required by Wayland. Enable kernel modesetting when using the NVIDIA proprietary driver.
      modesetting.enable = true;

      # Enable nvidia-settings, NVIDIA's GUI configuration tool.
      nvidiaSettings = true;

      # Enable experimental power management through systemd. Required for Wayland.
      powerManagement = {
        enable = true;
        finegrained = true;
      };

      # Use the stable NVIDIA driver package
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      # Whether to enable the open source NVIDIA kernel module.
      # Disabled since Nvidia cards work best with proprietary drivers.
      open = false;

      # Offload mode
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        # Make sure you set correct Bus IDs for the system
        # Use `lspci | grep VGA` to see list of display cards
        # Current system shows AMD as 11:00.0
        # We have set 17 since 11 (hex) equals 17 (decimal)
        # Reference: https://wiki.nixos.org/wiki/NVIDIA
        amdgpuBusId = "PCI:17:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  # Set of environment variables used in the global environment.
  # We set relevant variables to force system to use AMD iGPU instead of Nvidia dGPU.
  # We will also need to set Hyprland specific variables. See Hyprland config.
  # environment.sessionVariables = {
  #  LIBVA_DRIVER_NAME = "radeonsi";
  #  GBM_BACKEND = "radeonsi";
  #  __GLX_VENDOR_LIBRARY_NAME = "mesa";
  # };

  # Load nvidia drivers early to fix resolution issues with boot screens
  # boot = {
  #  initrd.kernelModules = [
  #    "nvidia"
  #    "nvidia_modeset"
  #    "nvidia_uvm"
  #    "nvidia_drm"
  #  ];

  #  extraModulePackages = [config.boot.kernelPackages.nvidiaPackages.stable];
  # };
}

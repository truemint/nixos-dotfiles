# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, flakeInputs, ... }:
{
  imports =
    [ 
      # Include the results of the hardware scan.
      # We reference to the system generated version of this file as opposed to keeping a copy
      # in our Git version controlled configs since this file will be unique to the system
      # and is not reusable.
      /etc/nixos/hardware-configuration.nix

      # Import the catppuccin/nix module
      flakeInputs.catppuccin.nixosModules.catppuccin

      # Import the home-manager module
      flakeInputs.home-manager.nixosModules.home-manager
    ];

  home-manager = {
    useGlobalPkgs = true;
    # useUserPackages = true;
    backupFileExtension = "backup";
    users = {
      truemint = {
        imports = [
	  ../../truemint-home.nix
	  flakeInputs.catppuccin.homeModules.catppuccin
	];
      };
    };
  };

  catppuccin = {
    flavor = "mocha";
    grub.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set Swap options
  # zramSwap enables ZRAM for high-speed compressed swap
  # swapDevices enable a swap file as a safety net in case ZRAM runs out
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;	# Max size of the ZRAM device
    priority = 100;	# Higher priority than swap file means it's used first
  };

  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 8192;	# 8GB in MB
    priority = 10;	# Lower priority than zramSwap means it's used only when ZRAM is full
  } ];

  # Tells Linux kernel to make good use of the ZRAM swap
  boot.kernel.sysctl = { "vm.swapiness" = 60; };

  # Set boot options
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      gfxmodeEfi = "3440x1440";
    };
  };

  boot.kernelParams = [ "video=3440x1440" ];

  nixpkgs.config.allowUnfree = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = true;
  };

  # Load nvidia drivers early to fix resolution for initial boot screens
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidiaPackages.stable ];

  # Set networking options
  # Configure network connections interactively with nmcli or nmtui
  networking = {
    hostName = "Truemint-NixOS";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    
    # Enable support for JACK applications
    jack.enable = true;
    
    # Use WirePlumber as the session manager
    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.truemint = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree
      ];
    };
  };

  fonts = {
    fontDir.enabled = true;
  };

  programs.bash.enable = false;
  programs.zsh.enable = true;

  # Facilitates ZSH syntax completion for system commands
  # Reference: http://www.mynixos.com/home-manager/option/programs.zsh.enableCompletion
  environment.pathsToLink = [ "/share/zsh" ];

  programs.firefox.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.ssh.startAgent = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    neovim	# Neovim editor
    wget
    btop	# System monitor
    git		# Version control
    bat		# Replacement for cat
    # kitty	# Default terminal for Hyprland
    # waybar
    # hyprpaper	# Wallpaper management
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}


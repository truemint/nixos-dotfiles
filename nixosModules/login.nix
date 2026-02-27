# Login manager configuration
{
  config,
  pkgs,
  ...
}: {
  # Set up SDDM as the display manager / login manager
  services.displayManager = {
    enable = true;
    # defaultSession = "hyprland";
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm; # Install the qt6 SDDM version
      # extraPackages = [pkgs.sddm-astronaut];
      # theme = "sddm-astronaut-theme";
      theme = "breeze";
    };
  };
  # environment.systemPackages = [pkgs.sddm-astronaut];

  # Set up gnome-keyring
  services.gnome.gnome-keyring.enable = true;

  # Use the modern GCR SSH agent (replaces the old integrated one)
  # Required for NixOS 24.11+. While enabling services.gnome.gnome-keyring.enable starts the core secret service (for passwords), it no longer implicitly manages the SSH agent because the GNOME project has split that functionality into the GCR (GNOME Crypto Release) package.
  services.gnome.gcr-ssh-agent.enable = true;

  # Disable ssh-agent to avoid conflict since we are using the GCR SSH agent
  programs.ssh.startAgent = false;

  # Signing into SDDM should automatically unlock the keyring
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Install "Seahorse" as the GUI to manage keyring
  programs.seahorse.enable = true;

  # Ensure that the D-Bus service for graphical prompts is active
  # so that apps can prompt if the keyring is locked
  services.dbus.packages = [
    pkgs.gnome-keyring
    pkgs.gcr
  ];

  # Polkit agent support (needed for privileged prompts)
  security.polkit.enable = true;

  # This tells UWSM to include the keyring as part of the session
  # systemd.user.services.gnome-keyring = {
  #   wantedBy = ["graphical-session.target"];
  # };
}

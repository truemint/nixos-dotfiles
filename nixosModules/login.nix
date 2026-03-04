# Login manager configuration
{
  config,
  pkgs,
  myConfig,
  ...
}: {
  # Setting up auto-login for primary user
  # This is okay from security perspective since we have full disk encryption
  services.getty = {
    autologinUser = myConfig.userName;
    autologinOnce = true;
  };

  # We have set up auto-start for Hyprland when we log in from tty
  # These settings are available along with Hyprland config

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

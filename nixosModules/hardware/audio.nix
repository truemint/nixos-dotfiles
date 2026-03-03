# Audio driver configuration
{
  config,
  pkgs,
  ...
}: {
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
}

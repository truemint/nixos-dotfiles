# App launcher config (rofi, wofi, tofi, etc.)
{
  config,
  pkgs,
  flakeInputs,
  ...
}: {
  imports = [flakeInputs.vicinae.homeManagerModules.default];
  services.vicinae = {
    enable = true;
    # settings reference: https://github.com/vicinaehq/vicinae/blob/main/extra/config.jsonc
    settings = {
      close_on_focus_loss = true;

      # Entry-point specific configuration
      providers = {
        applications = {
          preferences = {
            # Ensure that all apps launched by Vicinae are managed by UWSM
            launchPrefix = "uwsm-app -- ";
          };
        };
      };
    };

    # Ensure that Vicinae daemon is started whenever a graphical session is started
    systemd = {
      enable = true;
      autoStart = true;
      target = "graphical-session.target";
    };
  };
}

# App launcher config (rofi, wofi, tofi, etc.)
{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.rofi = {
    enable = false;

    modes = [
      "drun"
      "run"
      "calc"
      "emoji"
    ];

    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-emoji
    ];
  };

  services.vicinae = {
    package = pkgs.vicinae;
    enable = true;
    # settings reference: https://github.com/vicinaehq/vicinae/blob/main/extra/config.jsonc
    settings = {
      close_on_focus_loss = true;
      launcher_window = {
        opacity = 0.98;
      };

      providers = {
        applications = {
          preferences = {
            launchPrefix = "uwsm app -- ";
          };
        };
      };
    };
    systemd = {
      enable = true;
      autoStart = true;
      target = "graphical-session.target";
    };
  };
}

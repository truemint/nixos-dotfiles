# App launcher config (rofi, wofi, tofi, etc.)
{
  config,
  pkgs,
  flakeInputs,
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

  imports = [flakeInputs.vicinae.homeManagerModules.default];
  services.vicinae = {
    enable = true;
    # settings reference: https://github.com/vicinaehq/vicinae/blob/main/extra/config.jsonc
    settings = {
      close_on_focus_loss = true;

      providers = {
        applications = {
          preferences = {
            launchPrefix = "uwsm-app -- ";
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

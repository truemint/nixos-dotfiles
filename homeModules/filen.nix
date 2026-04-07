{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [filen-desktop];

  systemd.user.services.filen-desktop = {
    Unit = {
      Description = "Filen Desktop Client";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${pkgs.filen-desktop}/bin/filen-desktop";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}

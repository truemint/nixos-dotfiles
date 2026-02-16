{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./homeModules
  ];

  home = {
    username = "truemint";
    preferXdgDirectories = true;
    homeDirectory = "/home/truemint";
    stateVersion = "25.11";
  };

  # xdg.enable = true tells home-manager to create environment variables for
  # XDG_CONFIG_HOME and other related directories as per the XDG Base Directory Specification
  # https://specifications.freedesktop.org/basedir/latest/
  xdg.enable = true;

  catppuccin = {
    flavor = "mocha";
  };
}

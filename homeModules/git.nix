# Configuring Git
{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Shishir Srivastava";
        email = "github@truemint.email";
      };
    };
  };
}

# Fonts setup
{
  config,
  pkgs,
  ...
}: {
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["Fira Code"];
      };
    };
    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-monochrome-emoji
      nerd-fonts.fira-code
    ];
  };
}

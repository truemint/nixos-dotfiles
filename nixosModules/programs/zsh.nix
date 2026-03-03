# System level configuration for ZSH
{
  config,
  pkgs,
  ...
}: {
  # Enable ZSH
  programs.zsh.enable = true;

  # Set up ZSH as the default shell for all users
  users.defaultUserShell = pkgs.zsh;

  # Facilitate ZSH syntax completion for system commands
  # Reference: http://www.mynixos.com/home-manager/option/programs.zsh.enableCompletion
  environment.pathsToLink = ["/share/zsh"];
}

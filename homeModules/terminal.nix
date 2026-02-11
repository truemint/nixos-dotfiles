# Shell and Terminal configuration

{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      test = "echo 'Truemint zsh config test'";
    };

    history = {
      size = 10000;
      ignoreAllDups = true;
    };
  };
};

# Shell and Terminal configuration

{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;

    historyIgnore = [
      "ls"
      "passwd"
      "pwd"
      "exit"
      "history"
    ];
    historyControl = [ "ignoreboth" ];
  };
}

# Shell and Terminal configuration

{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
  fonts.fontconfig.enable = true;

  programs.ghostty = {
    enable = true;
    settings = {};
    themes = {};
  };

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = [ "main" "brackets" ];
    };

    history = {
      size = 5000;
      save = 5000;
      share = true; #Share history between different open terminal windows
      ignoreDups = true;
      ignorePatterns = [
        "rm *"
	"pkill *"
	"history"
	"ls -la"
	"exit"
	"pwd"
	"passwd"
      ];
    };

    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      test-zsh = "echo \'Truemint test\'";
    };
  };

  programs.bash = {
    enable = false;

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

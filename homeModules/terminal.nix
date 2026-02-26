# Shell and Terminal configuration
{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "FiraCode Nerd Font";
      font-size = 15;
      theme = "Primary";
    };
  };
  # catppuccin.ghostty.enable = true;

  programs.zsh = {
    enable = true;

    dotDir = "${config.xdg.configHome}/zsh";

    enableCompletion = true;

    autosuggestion = {
      enable = true;
      highlight = "fg=#ff00ff,bg=cyan,bold,underline";
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets"];
      # styles = {};
    };

    # Set ZSH to default to Vim keys. This implicitly happens if Vi/Vim/Neovim are set as default editors on the system. Declaring this here explicitly makes our system more deterministic.
    defaultKeymap = "viins";

    # Set Ctrl+R to command history search
    # This is default is emacs keymap, but in vi keymap Ctrl+R is set to something else. We change this explicitly to our preferred mapping.
    # bindkey "^R" history-incremental-search-backward

    # Enable history searching using up/down keys.
    historySubstringSearch.enable = true;

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

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  catppuccin.fzf.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "[░▒▓](fg:peach)"
        # "[](red)"
        # "$os"
        # "$username"
        # "[](bg:peach fg:red)"
        "$directory"
        "[](bg:yellow fg:peach)"
        "$git_branch"
        "$git_status"
        "[](fg:yellow bg:green)"
        "$c"
        "$rust"
        "$golang"
        "$nodejs"
        # "$php"
        # "$java"
        # "$kotlin"
        # "$haskell"
        # "$python"
        "[](fg:green bg:sapphire)"
        # "$conda"
        "$git_state"
        "[](fg:sapphire bg:lavender)"
        "$time"
        "[ ](fg:lavender)"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];
      os = {
        disabled = true;
        style = "bg:red fg:crust";
        symbols = {
          Windows = "";
          Ubuntu = "󰕈";
          SUSE = "";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Macos = "󰀵";
          Manjaro = "";
          Linux = "󰌽";
          Gentoo = "󰣨";
          Fedora = "󰣛";
          Alpine = "";
          Amazon = "";
          Android = "";
          AOSC = "";
          Arch = "󰣇";
          Artix = "󰣇";
          CentOS = "";
          Debian = "󰣚";
          Redhat = "󱄛";
          RedHatEnterprise = "󱄛";
        };
      };

      username = {
        disabled = true;
        show_always = true;
        style_user = "bg:red fg:crust";
        style_root = "bg:red fg:crust";
        format = "[ $user]($style)";
      };

      directory = {
        style = "bg:peach fg:crust";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";

        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "Developer" = "󰲋 ";
        };
      };
      git_branch = {
        symbol = "";
        style = "bg:yellow";
        format = "[[ $symbol $branch ](fg:crust bg:yellow)]($style)";
      };

      git_state = {
        style = "bg:yellow";
        format = "[[($state ($progress_current of $progress_total) )](fg:crust bg:yellow)]($style)";
      };

      git_status = {
        style = "bg:yellow";
        format = "[[($all_status$ahead_behind )](fg:crust bg:yellow)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
      };

      java = {
        symbol = " ";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
      };

      kotlin = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
      };

      haskell = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
      };

      python = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version)(\(#$virtualenv\)) ](fg:crust bg:green)]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:lavender";
        format = "[[  $time ](fg:crust bg:lavender)]($style)";
      };

      character = {
        disabled = false;
        success_symbol = "[❯](bold fg:green)";
        error_symbol = "[❯](bold fg:red)";
        vimcmd_symbol = "[❮](bold fg:green)";
        vimcmd_replace_one_symbol = "[❮](bold fg:lavender)";
        vimcmd_replace_symbol = "[❮](bold fg:lavender)";
        vimcmd_visual_symbol = "[❮](bold fg:yellow)";
      };

      cmd_duration = {
        show_milliseconds = true;
        format = " in $duration ";
        style = "bg:lavender";
        disabled = false;
        show_notifications = true;
        min_time_to_notify = 45000;
      };
    };
  };
  catppuccin.starship.enable = true;
}

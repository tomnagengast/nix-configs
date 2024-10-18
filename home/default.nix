{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.props;
in
{
  imports = [
    ./git
    ./neovim
    ./zsh
  ];
  
  options.props = {
    useNeovim = lib.mkEnableOption "neovim";
  };

  config = {
    xdg.configFile = {
      "dbt/profiles.yml".source = ./dbt/profiles.yml;
      "tmux/tmux.conf".source = ./tmux/tmux.conf;
    };

    home = {
      stateVersion = "24.11";

      packages = with pkgs; [
        _1password
        bat
        delta
        fzf
        gcc
        gh
        gnupg
        jq
        lsd
        pure-prompt
        tmux
        tree
      ];

      sessionVariables = {
        EDITOR = "cursor";
        DBT_STATE = "target/production";
        DBT_PROFILES_DIR = ".config/dbt";
        DBT_DEFER = "true";
        DBT_CLOUD_ACCOUNT_ID = "211006";
        DBT_CLOUD_PROJECT_ID = "304574";
      };

      sessionPath = [
          "$HOME/bin"
      ];

      file = {
        "bin" = {
          source = ./scripts;
          recursive = true;
        };
      };
    };

    programs = {
      home-manager.enable = true;

      bat = {
        enable = true;
        config.theme = "Nord";
      };

      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
        
      tmux = {
        enable = true;
      };
    };
  };
}

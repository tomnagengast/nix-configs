{ pkgs, lib, ... }:
with lib;
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
        git-recent
        gnupg
        jq
        k9s
        lsd
        nil
        nodejs
        ripgrep
        uv
        tmux
        tree
        (google-cloud-sdk.withExtraComponents [
          google-cloud-sdk.components.gke-gcloud-auth-plugin
        ])
      ];

      sessionVariables = {
        EDITOR = "nvim";
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

      starship = {
        enable = true;
        settings = {
          character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[➜](bold red)";
          };
          aws.disabled = true;
          docker_context.disabled = true;
          gcloud.disabled = true;
          # python.disabled = true;
          package.disabled = true;
        };
      };
        
      tmux = {
        enable = true;
      };
    };
  };
}

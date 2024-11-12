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
        devenv
        duckdb
        fzf
        gcc
        gh
        git-recent
        gnupg
        go
        go-tools
        gopls
        jq
        k9s
        lsd
        nil
        nodejs
        ripgrep
        tmux
        tree
        universal-ctags
        uv
        (google-cloud-sdk.withExtraComponents [
          google-cloud-sdk.components.gke-gcloud-auth-plugin
        ])
      ];

      sessionVariables = {
        EDITOR = "nvim";
        GOPATH = "$HOME/go";
        GOBIN = "$GOPATH/bin";
        GO111MODULE = "on";
      };

      sessionPath = [
          "$HOME/bin"
          "$GOPATH/bin"  # Add GOBIN to PATH
      ];

      file = {
        "bin" = {
          source = ./scripts;
          recursive = true;
        };
        ".golangci.yml" = {
          text = ''
            linters:
              enable:
                - gofmt
                - golint
                - govet
                - errcheck
                - staticcheck
                - gosimple
                - ineffassign
              disable:
                - deadcode  # Deprecated
                - varcheck  # Deprecated
            run:
              deadline: 5m
          '';
        };  # Added missing closing brace here
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
          package.disabled = true;
        };
      };
        
      tmux = {
        enable = true;
      };
    };
  };
}

{ pkgs, pkgs-unstable, lib, ... }:
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

      packages = [
        pkgs._1password
        pkgs.bat
        pkgs.bun
        pkgs.cargo
        pkgs.comma
        pkgs.delta
        pkgs-unstable.devenv
        pkgs.direnv
        pkgs.duckdb
        pkgs.fzf
        pkgs.gcc
        pkgs.gh
        pkgs.git-recent
        pkgs.go
        pkgs.gopls
        pkgs.golangci-lint
        pkgs.gotools
        pkgs.gnupg
        pkgs.helmfile
        pkgs.httpie
        pkgs.jq
        pkgs.k9s
        (pkgs.wrapHelm pkgs.kubernetes-helm { plugins = [ pkgs.kubernetes-helmPlugins.helm-diff ]; })
        pkgs.kubectx
        pkgs.lsd
        pkgs.netlify-cli
        pkgs.nil
        pkgs.nodejs
        pkgs.nodePackages.npm
        pkgs.nodePackages_latest.prettier
        pkgs.openssl_3
        pkgs.python314
        pkgs.ripgrep
        pkgs.rustc
        pkgs.sqlite
        pkgs.tmux
        pkgs.tree
        pkgs.universal-ctags
        pkgs-unstable.uv
        pkgs.yarn
        (pkgs.google-cloud-sdk.withExtraComponents [
            pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
            pkgs.google-cloud-sdk.components.kubectl
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
          package.disabled = true;
        };
      };

      tmux = {
        enable = true;
      };
    };
  };
}

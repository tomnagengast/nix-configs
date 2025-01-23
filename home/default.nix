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
        bun
        cargo
        comma
        delta
        devenv
        direnv
        duckdb
        fzf
        gcc
        gh
        git-recent
        go
        gopls
        golangci-lint
        gotools
        gnupg
        helmfile
        httpie
        jq
        k9s
        (pkgs.wrapHelm pkgs.kubernetes-helm { plugins = [ pkgs.kubernetes-helmPlugins.helm-diff ]; })
        kubectx
        lsd
        netlify-cli
        nil
        nodejs
        nodePackages.npm
        nodePackages_latest.prettier
        openssl_3
        ripgrep
        rustc
        sqlite
        tmux
        tree
        universal-ctags
        uv
        yarn
        (google-cloud-sdk.withExtraComponents [
            google-cloud-sdk.components.gke-gcloud-auth-plugin
            google-cloud-sdk.components.kubectl
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

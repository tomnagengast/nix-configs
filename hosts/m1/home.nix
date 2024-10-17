{
  pkgs,
  config,
  ...
}: {
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home = {
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
      neovim
      pure-prompt
      tmux
      tree
    ];

    sessionVariables = {
      EDITOR = "cursor";
      DBT_STATE = "target/production";
      DBT_DEFER = "true";
      DBT_CLOUD_ACCOUNT_ID = "211006";
      DBT_CLOUD_PROJECT_ID = "304574";
    };

    sessionPath = [
      "$HOME/bin"
    ];
  };

  programs.bat = {
    enable = true;
    config.theme = "Nord";
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
  };
}

{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.props;
in
{
  imports = [
    ./bat
    ./direnv
    ./fzf
    ./git
    ./tmux
    ./zsh
  ];
  
  options.props = {
    useNeovim = lib.mkEnableOption "neovim";
  };

  config = {
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

    programs.home-manager.enable = true;
  };
}

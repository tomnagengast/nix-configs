{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.my-home;
in
{

  # imports = [
  #   ./direnv
  #   ./gh
  #   ./git
  #   ./nvim
  #   ./tmux
  #   ./zsh
  # ];

  config = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home = {
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
    };

    fonts.fontconfig.enable = cfg.includeFonts;

    programs.nix-index.enable = true;

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "24.05";
  };

}

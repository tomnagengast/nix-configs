{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.props;
in
{
  imports = [
    ./git
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

    programs.tmux = {
      enable = true;
      # extraConfig = builtins.readFile ./tmux/tmux.conf;
    };

    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      history.ignoreDups = true;
      history.ignorePatterns = ["ls"];
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "direnv"];
      };
      # initExtra = builtins.readFile ./zsh/zshrc;
      initExtra = ''
        zstyle ':omz:update' mode auto

        autoload -U promptinit; promptinit
        zstyle :prompt:pure:git:branch color '#56526e'
        zstyle :prompt:pure:git:dirty color '#56526e'
        zstyle :prompt:pure:path color green
        zstyle ':prompt:pure:prompt:*' color cyan
        zstyle :prompt:pure:prompt:continuation color cyan
        zstyle :prompt:pure:virtualenv color cyan
        prompt pure

        source ~/.orbstack/shell/init.zsh 2>/dev/null || :
        source ~/.aliases.zsh
        source ~/.functions.zsh
      '';
      envExtra = "source ${config.home.homeDirectory}/dotfiles/zsh/zshenv";
    };
  };
}

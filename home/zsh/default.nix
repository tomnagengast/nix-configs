{ config, pkgs, ... }: {

  xdg.configFile = {
    "zsh/aliases.zsh".source = ./aliases.zsh;
    "zsh/functions.zsh".source = ./functions.zsh;
  };

  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      history.ignoreDups = true;
      history.ignorePatterns = ["ls"];
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "direnv"];
      };
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
        # source ~/.aliases.zsh
        # source ~/.functions.zsh
      '';
      envExtra = "source ${config.home.homeDirectory}/nix-configs/home/zsh/zshenv.zsh";
    };
  };
}

{ config, pkgs, ... }: {
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
        ${builtins.readFile ./aliases.zsh}
        ${builtins.readFile ./functions.zsh}
        source ~/.zshenv
      '';
    };
  };
}

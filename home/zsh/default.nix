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
        source ~/.orbstack/shell/init.zsh
        ${builtins.readFile ./aliases.zsh}
        ${builtins.readFile ./functions.zsh}
        source ~/.zshenv
      '';
    };
  };
}

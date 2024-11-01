{ ... }: {
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      history.ignoreDups = true;
      history.ignorePatterns = [
        "h"
        "l *"
        "ll *"
        "ls *"
        "cd *"
        "gr"
        "pwd"
      ];
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "direnv"];
      };
      initExtra = ''
        ${builtins.readFile ./aliases.zsh}
        ${builtins.readFile ./functions.zsh}
        source ~/.zshenv
        export PATH=/opt/homebrew/bin:$PATH
        export DBT_PROFILES_DIR="$HOME/.config/dbt"
        export GOPATH=$HOME/go
        export PATH=$PATH:$GOPATH/bin
        
        # Activate virtual environment if it exists
        if [ -d .venv ]; then
          source .venv/bin/activate
        fi
      '';
    };
  };
}

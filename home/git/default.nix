{ config, pkgs, lib, ... }: {

  xdg.configFile."1Password/ssh/agent.toml" = {
    source = ./agent.toml;
  };

  programs = {
    git = {
      enable = true;
      userEmail = "tnagengast@gmail.com";
      userName = "tomnagengast";
      signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB3FOfHxMK6gmUS+IAjVKt8ZuAO4nrZbi5HgXJfF0BTZ";
      signing.signByDefault = true;
      ignores = lib.splitString "\n" (builtins.readFile ./gitignore_global);

      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
          keep-plus-minus-markers = true;
        };
      };

      extraConfig = {
        commit.gpgSign = true;
        gpg = {
          format = "ssh";
          ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        };
        credential.helper = "osxkeychain";
        color.ui = "auto";
        diff.renames = "copies";
        push = {
          default = "simple";
          autoSetupRemote = true;
        };
        pull.rebase = false;
        github.user = "tomnagengast";
        merge.conflictstyle = "diff3";
        init.defaultBranch = "main";
      };

      aliases = {
        # Show the diff between the latest commit and the current state
        d = "!git diff-index --quiet HEAD -- || clear; git --no-pager diff --patch-with-stat";
        # Switch to a branch, creating it if necessary
        go = "!f() { git checkout -b \"$1\" 2> /dev/null || git checkout \"$1\"; }; f";
        # Show verbose output about tags, branches or remotes
        tags = "tag -l";
        branches = "branch -a";
        remotes = "remote -v";
        # List aliases
        aliases = "config --get-regexp alias";
        # Amend the currently staged files to the latest commit
        amend = "commit --amend --reuse-message=HEAD";
        # Remove branches that have already been merged with master
        dm = "!git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d";
        # List contributors with number of commits
        contributors = "shortlog --summary --numbered";
      };
    };
  };
}


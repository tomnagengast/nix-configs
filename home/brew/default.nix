{ config, pkgs, ... }: {
  programs = {
    homebrew = {
      enable = true;

      brews = [
        "go" # install for system to use apple sdk frameworks unavailable to nixpkgs
      ];
    };
  };
}

{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.my-darwin;
in
{

  imports = [
    # ./system-defaults
    # ./homebrew
  ];

  config = {
    # Make sure nix always runs in multi-user mode on Mac
    services.nix-daemon.enable = true;

    nix.package = pkgs.nixStable;
    nix = {
      settings = {
        experimental-features = "nix-command flakes";
        cores = 0; # use all cores
        max-jobs = 10; # use all cores
      };
    };

    # Create /etc/zshrc that loads the nix-darwin environment.
    programs.zsh = {
      enable = true;
      # This fixes a bug between nix darwin and home-manager over completion conflicts
      # Completion is enabled in home-manager config
      enableCompletion = false;
      promptInit = "";
    };

    security.pam.enableSudoTouchIdAuth = cfg.enableSudoTouch;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 5;
  };

}

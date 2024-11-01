{ global, ... }: {

  programs.zsh.enable = true;
  environment.pathsToLink = ["/share/zsh"];

  services.nix-daemon.enable = true;
  nix = {
    settings = {
      cores = 0;
      max-jobs = 10;
      experimental-features = "nix-command flakes";
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  system.stateVersion = 5;

  users.users.${global.user.unixname} = {
    name = global.user.unixname;
    home = "/Users/${global.user.unixname}";
  };
}

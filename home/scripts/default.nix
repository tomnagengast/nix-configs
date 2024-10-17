{ config, pkgs, ... }: {
  xdg.configFile."scripts/aliases.sh".source = ./aliases.sh;
}

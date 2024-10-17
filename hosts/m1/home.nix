{ config, pkgs, ... }: {
  imports = [
    ../../home
  ];

  props = {
    useNeovim = true;
  };
}

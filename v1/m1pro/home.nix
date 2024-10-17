{ config, pkgs, ... }: {
  imports = [
    ../../home
  ];

  my-home = {
    isWork = false;
  };
}

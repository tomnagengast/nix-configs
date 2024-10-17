{ config, pkgs, ... }: {
  imports = [
    ../../darwin
  ];

  my-darwin = {
    isWork = false;
    enableSudoTouch = true;
  };
}

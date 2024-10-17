{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, ...}: let
    initModules = { host, user }: [
      # Main config
      (./. + "/hosts/${host}/configuration.nix")
      home-manager.${if host == "m1" then "darwinModules" else "nixosModules"}.home-manager
      {
        nixpkgs.config.allowUnfree = true;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user.unixname} = import (./. + "/hosts/${host}/home.nix");
      }
    ];
    user = {
      unixname = "tomnagengast";
      name = "Tom Nagengast";
      email = "tnagengast@gmail.com";
    };
  in {
    darwinConfigurations.tom-m1 = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = initModules { host = "m1"; user = user; };
      specialArgs = {
        inherit home-manager;
        global = {
          inherit user;
          host = "m1";
        };
      };
    };

    homeConfigurations.tom-vm = home-manager.lib.homeManagerConfiguration {
      system = "x86_64-linux";
      modules = initModules { host = "vm"; user = user; };
      specialArgs = {
        inherit home-manager;
        global = {
          inherit user;
          host = "vm";
        };
      };
    };
  };
}

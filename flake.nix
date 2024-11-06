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
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    sf-mono = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };
  };

  outputs = { home-manager, darwin, nix-homebrew, nixpkgs, sf-mono, ...}: 
  let 
    overlays = [
      (final: prev: {
        sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation rec {
          pname = "sf-mono-liga-bin";
          version = "dev";
          src = sf-mono;
          dontConfigure = true;
          installPhase = ''
            mkdir -p $out/share/fonts/opentype
            cp -R $src/*.otf $out/share/fonts/opentype/
          '';
        };
      })
    ];
    initModules = { host, user }: [
      (./. + "/hosts/${host}/configuration.nix")
      nix-homebrew.darwinModules.nix-homebrew
      {
        nix-homebrew = {
          # enable = true;
          user = user.unixname;
        };
      }
      home-manager.${if host == "m1" then "darwinModules" else "nixosModules"}.home-manager
      {
        nixpkgs.config.allowUnfree = true;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user.unixname} = import (./. + "/hosts/${host}/home.nix");
      }
    ];
    user = {
      unixname = "tom";
      name = "Tom Nagengast";
      email = "tnagengast@gmail.com";
    };
    
  in {
    darwinConfigurations.tom-m1 = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = initModules { inherit user; host = "m1"; };
      specialArgs = {
        inherit home-manager user overlays;
      };
    };

    homeConfigurations.tom-vm = home-manager.lib.homeManagerConfiguration {
      system = "x86_64-linux";
      modules = initModules { inherit user; host = "vm"; };
      specialArgs = {
        inherit home-manager user;
      };
    };
  };
}

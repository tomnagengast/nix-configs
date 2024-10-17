{
  description = "Nix dotfiles configuration";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    # Environment/system management
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Other sources
    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
    # flake-root.url = "github:srid/flake-root";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    # flake-compat = {
    #   url = "github:edolstra/flake-compat";
    #   flake = false;
    # };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    darwin,
    systems,
    flake-parts,
    flake-utils,
    ...
  }: 
  let
    nixpkgsConfig = with inputs; {
      config = {
        allowUnfree = true;
      };
    };
    commonModules = { user, host }: with inputs; [
      # Main config
      (./. + "/hosts/${host}/configuration.nix")
      # `home-manager` module
      {
        nixpkgs = nixpkgsConfig;
        home-manager = {
          useGlobalPkgs = true;
          users.${user} = import (./. + "/hosts/${host}/home.nix");
        };
      }
    ];
    darwinModules = { user, host }: with inputs;
      commonModules { inherit user host; } ++ [
        home-manager.darwinModules.home-manager
        {
          # `home-manager` config
          users.users.${user}.home = "/Users/${user}";
        }
      ];
  in
  flake-parts.lib.mkFlake { inherit inputs; } {
    flake = {
      darwinConfigurations = {
        m1pro = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = darwinModules {
            user = "tomnagengast";
            host = "m1pro";
          };
          specialArgs = { inherit inputs nixpkgs; };
        };
      };
    };
  };
}

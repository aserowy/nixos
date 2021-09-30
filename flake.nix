{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    /* dots = {
      url = "github:aserowy/dots";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    }; */
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { home-manager, nixpkgs, ... }: {
    nixosConfigurations = {
      workstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
          ./packages.nix
          home-manager.nixosModule {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              users.serowy = import ./home/environments/desktop.nix;
            };
          }
          /* ({config, lib, pkgs, utils,...}: dots.nixosModules."serowy@desktop-nixos" {
            config = config;
            lib = lib;
            pkgs = pkgs;
            utils = utils;
          }) */
        ];
      };
    };
  };
}

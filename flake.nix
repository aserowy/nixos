{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    /* dots = {
      url = "github:aserowy/dots";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    }; */
    home-manager = {
      url = "github:nix-community/home-manager/release-21.05";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { home-manager, nixpkgs, nixpkgs-unstable, ... }: {
    nixosConfigurations = {
      workstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ config, pkgs, ... }:
            let
              overlay-unstable = final: prev: {
                unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
              };
            in
            {
              nixpkgs.overlays = [ overlay-unstable ];

              imports =
                [
                  ./hardware-configuration.nix
                  ./configuration.nix
                  ./packages.nix
                ];
            }
          )
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

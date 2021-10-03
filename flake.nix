{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home.url = "github:nix-community/home-manager";
  };

  outputs = { home, nixpkgs, nixpkgs-unstable, ... }: {
    nixosConfigurations = {
      workstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ config, pkgs, ... }: let
            overlay-unstable = final: prev: {
              unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
            };
          in {
            nixpkgs.overlays = [ overlay-unstable ];

            imports = [
              ./hardware-configuration.nix
              ./configuration.nix
            ];
          })
	  home.nixosModule {
            home-manager = {
	      useGlobalPkgs = true;
              useUserPackages = true;

              users.serowy = import ./home/environments/desktop.nix;
            };
          }
        ];
      };
    };
  };
}

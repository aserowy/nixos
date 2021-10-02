{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    dots = {
      url = "github:aserowy/dots";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    /* home-manager.url = "github:nix-community/home-manager"; */
  };

  /* outputs = { nixpkgs, nixpkgs-unstable, ... }: { */
  outputs = { dots, nixpkgs, nixpkgs-unstable, ... }: {
  /* outputs = { home-manager, nixpkgs, nixpkgs-unstable, ... }: { */
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
                ];
            }
          )
          /* home-manager.nixosModule {
            home-manager = {
              useUserPackages = true;

              users.serowy = import ./home/environments/desktop.nix;
            };
          } */
          dots.nixosModules."serowy@desktop-nixos"
        ];
      };
    };
  };
}

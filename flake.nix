{
  description = "NixOS configuration";

  inputs = {
    home.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { home, nixpkgs, nur, ... }: {
    nixosConfigurations = {
      workstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home.nixosModule
          {
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

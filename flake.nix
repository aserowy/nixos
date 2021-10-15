{
  description = "NixOS configuration";

  inputs = {
    home.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
#    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nur.url = "github:nix-community/NUR";
  };

  #outputs = { home, nixpkgs, nixpkgs-wayland, nur, ... }: {
  outputs = { home, nixpkgs, nur, ... }: {
    nixosConfigurations = {
      desktop-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          {
            nixpkgs.overlays = [
#              nixpkgs-wayland.overlay
              nur.overlay

              (import ./home/pkgs)
            ];
          }
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

{
  description = "NixOS configurations";

  inputs = {
    fenix.url = "github:nix-community/fenix";
    home.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { fenix, home, nixpkgs, nur, ... }: {
    nixosConfigurations = {
      desktop-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            nixpkgs.overlays = [
              nur.overlay
              fenix.overlay

              # TODO: more elegant way to bind overlay in picom.nix directly
              (import ./overlays/picom.nix)

              (import ./home/pkgs)
            ];
          }

          ./system/intel_nuc
          ./shell/i3

          ./users/serowy.nix

          home.nixosModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.serowy = import ./home/environments/desktop-i3.nix;
            };
          }
        ];
      };
    };
  };
}

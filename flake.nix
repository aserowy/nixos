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

              (import ./home/pkgs)
            ];
          }

          ./system/intel_nuc
          ./shell/sway

          ./users/serowy.nix

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

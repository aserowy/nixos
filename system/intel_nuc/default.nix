{ config, pkgs, ... }:
{
  imports = [
    ../base.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop-nixos";

  services = {
    onedrive.enable = true;

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
      socketActivation = true;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      enableOnBoot = true;
    };
  };
}

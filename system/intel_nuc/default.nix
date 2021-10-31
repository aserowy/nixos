{ config, pkgs, ... }:
{
  imports = [
    ../base

    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop-nixos";

  services = {
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

{ config, pkgs, ... }:
{
  imports = [
    ../base.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop-workstation";

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

    xserver.videoDrivers = [ "nvidia" ];
  };

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      enableOnBoot = true;
    };
  };
}

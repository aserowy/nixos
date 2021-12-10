{ config, pkgs, ... }:
{
  imports = [
    ../base.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop-workstation";

  services = {
    # lsblk --discard to ensure ssd supports trim (disc-gran and disc-max should be non zero)
    fstrim.enable = true;

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

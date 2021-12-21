{ config, pkgs, ... }:
{
  imports = [
    ../base.nix

    ./borgbackup.nix
    ./hardware-configuration.nix
    ./hassio.nix
  ];

  networking.hostName = "homeassistant";

  services = {
    # lsblk --discard to ensure ssd supports trim (disc-gran and disc-max should be non zero)
    fstrim.enable = true;
  };

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      enableOnBoot = true;
    };
  };
}

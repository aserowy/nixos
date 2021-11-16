{ config, pkgs, ... }:
{
  imports = [
    ../base.nix

    ./borgbackup.nix
    ./hardware-configuration.nix
    ./hassio
  ];

  networking.hostName = "homeassistant";

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      enableOnBoot = true;
    };
  };
}

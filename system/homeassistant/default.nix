{ config, pkgs, ... }:
{
  imports = [
    ../base.nix
    ./hardware-configuration.nix

    ./borgbackup.nix
    ./hassio.nix
  ];

  networking = {
    hostName = "homeassistant";
    interfaces.eth0.useDHCP = true;
  };

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      enableOnBoot = true;
    };
  };
}

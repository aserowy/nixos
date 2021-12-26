{ config, pkgs, ... }:
{
  imports = [
    ../base.nix
    ./hardware-configuration.nix

    ../intel_nuc/borgbackup.nix
    ../intel_nuc/hassio.nix
  ];

  networking.hostName = "homeassistant-test";

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      enableOnBoot = true;
    };
  };
}

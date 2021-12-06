{ config, pkgs, ... }:
{
  imports = [
    ../base.nix

    ../intel_nuc/borgbackup.nix
    ../intel_nuc/hassio.nix
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

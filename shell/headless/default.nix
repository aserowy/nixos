{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lf
    wezterm
  ];

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      enableOnBoot = true;
    };
  };
}

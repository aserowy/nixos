{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    playerctl
    spicetify-cli
    spotify
  ];
}

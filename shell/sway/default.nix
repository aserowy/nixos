{ config, pkgs, ... }:
{
  imports = [
    ./gtk.nix
    ./sway.nix
  ];

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      powerline-fonts
      nerdfonts
    ];
  };

  programs = {
    seahorse.enable = true;
    steam.enable = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;
  };
}

{ config, pkgs, ... }:
{
  imports = [
    #./greetd.nix

    ./gtk.nix
    ./kanshi.nix
    ./sway.nix
    ./swayidle.nix
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

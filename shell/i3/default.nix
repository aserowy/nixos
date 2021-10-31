{ config, pkgs, ... }:
{
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

  xdg = {
    portal = {
      enable = true;
      gtkUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
  };
}


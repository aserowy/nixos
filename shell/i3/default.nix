{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    edge
    lf
    pavucontrol
    wezterm
  ];

  imports = [
    ../shared/alacritty.nix
    ../shared/dunst.nix
    ../shared/gtk.nix
    ../shared/rofi
    ../shared/spotify.nix

    ./i3
    ./lightdm.nix
    ./picom.nix
    ./polybar
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


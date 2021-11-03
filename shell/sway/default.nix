{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    edge
    pavucontrol
    sway-contrib.grimshot
    wezterm
  ];

  imports = [
    # FIX: needs config under home
    #./kanshi.nix

    ../shared/alacritty.nix
    ../shared/dunst.nix

    ./gtk.nix
    ./tuigreeter.nix
    ./rofi
    ./spotify.nix
    ./sway
    ./swayidle.nix
    ./waybar
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

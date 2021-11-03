{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    edge
    lf
    pavucontrol
    sway-contrib.grimshot
    wezterm
  ];

  imports = [
    ../shared/alacritty.nix
    ../shared/dunst.nix
    ../shared/gtk.nix
    ../shared/spotify.nix

    # FIX: needs config under home
    #./kanshi.nix

    ./tuigreeter.nix
    ./rofi
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

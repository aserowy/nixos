{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pavucontrol
    sway-contrib.grimshot
    wezterm
  ];

  imports = [
    # FIX: not functional right now
    #./greetd.nix

    # FIX: needs config under home
    #./kanshi.nix

    ../shared/dunst.nix

    ./gtk.nix
    ./rofi
    ./spotify.nix
    ./sway.nix
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

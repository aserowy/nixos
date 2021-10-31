{ config, pkgs, ... }:
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      jq
      pv

      dunst
      rofi
      sway-unwrapped
      sway-contrib.grimshot
      swaybg
      swayidle
      swappy
      waybar
      wf-recorder

      xorg.xlsclients
      xwayland
    ];
  };
}

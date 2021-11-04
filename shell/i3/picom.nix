{ config, pkgs, ... }:
{
  services.picom = {
    enable = true;
    activeOpacity = 0.95;
    backend = "glx";
    fade = true;
    inactiveOpacity = 0.8;
    settings = {
      blur = {
        method = "dual_kawase";
        kern = "3x3box";
      };
      corner = {
        radius = 6.0;
      };
    };
    shadow = true;
    vSync = true;
  };
}

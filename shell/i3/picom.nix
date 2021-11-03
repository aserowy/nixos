{ config, pkgs, ... }:
{
  services.picom = {
    enable = true;
    activeOpacity = 0.95;
    backend = "glx";
    inactiveOpacity = 0.8;
    settings = {
      blur = {
        method = "gaussian";
        size = 10;
        deviation = 5.0;
      };
    };
    shadow = true;
  };
}

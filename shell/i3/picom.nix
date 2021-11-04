{ config, pkgs, ... }:
{
  services.picom = {
    enable = true;
    experimentalBackends = true;

    activeOpacity = 1;
    backend = "glx";
    fade = true;
    inactiveOpacity = 0.8;
    settings = {
      blur-method = "dual_kawase";
      blur-kern = "3x3box";
      corner-radius = 12;
    };
    vSync = true;

    # FIX: rounded border with shadow is bugged
    shadow = false;
  };
}

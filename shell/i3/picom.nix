{ config, pkgs, ... }:
{
  services.picom = {
    enable = true;
    experimentalBackends = true;

    activeOpacity = 0.9;
    backend = "glx";
    fade = true;
    inactiveOpacity = 0.8;
    menuOpacity = 0.9;
    opacityRules = [
      "99:class_g = 'Microsoft-edge'"
    ];
    settings = {
      blur-background = true;
      blur-method = "dual_kawase";
      blur-kern = "3x3box";
      corner-radius = 6;
      frame-opacity = 1.0;
    };
    vSync = true;
    wintypes = {
      tooltip = {
        focus = true;
        opacity = 0.75;
      };
    };

    # FIX: rounded border with shadow is bugged
    shadow = true;
  };
}

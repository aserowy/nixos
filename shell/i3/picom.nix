{ config, pkgs, ... }:
{
  services.picom = {
    enable = true;
    experimentalBackends = true;

    activeOpacity = 0.9;
    backend = "glx";
    fade = true;
    inactiveOpacity = 0.8;
    menuOpacity = 0.8;
    opacityRules = [
      "99:_NET_WM_STATE@:32a = '_NET_WM_STATE_FULLSCREEN'"

      "99:class_g = 'Microsoft-edge'"
      "80:class_g = 'Polybar'"
    ];
    settings = {
      blur-background = true;
      blur-method = "dual_kawase";
      blur-kern = "3x3box";
      corner-radius = 6;
      frame-opacity = 0.9;
    };
    vSync = true;
    wintypes = {
      tooltip = {
        focus = true;
        opacity = 0.8;
      };
    };

    # FIX: rounded border with shadow is bugged
    shadow = true;
  };
}

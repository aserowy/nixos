{ config, pkgs, ... }:
{
  environment = {
    pathsToLink = [ "/libexec" ];
  };

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };

    displayManager = {
      defaultSession = "xfce+i3";
    };

    windowManager.i3 = {
      enable = true;
      configFile = ./src/config;
      extraPackages = with pkgs; [
        dmenu
      ];
      package = pkgs.i3-gaps;
    };
  };
}

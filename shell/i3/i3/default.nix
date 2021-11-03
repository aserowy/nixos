{ config, pkgs, ... }:
{
  environment = {
    etc = {
      "i3/config".source = ./src/config;
    };

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
      configFile = /etc/i3/config;
      extraPackages = with pkgs; [
        dmenu
      ];
      package = pkgs.i3-gaps;
    };
  };
}

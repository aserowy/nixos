{ config, pkgs, ... }:
{
  environment = {
    etc = {
      "i3/scripts".source = ./src/scripts;
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
      configFile = ./src/config;
      extraPackages = with pkgs; [
        feh
      ];
      package = pkgs.i3-gaps;
    };
  };
}

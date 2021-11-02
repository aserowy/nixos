{ config, pkgs, lib, ... }:
{
  environment.etc = {
    "sway/config".source = ./src/config;
    "sway/scripts".source = ./src/scripts;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      jq
      pv
      sway-unwrapped
      swaybg
      swappy
      wf-recorder

      xorg.xlsclients
      xwayland
    ];
  };

  systemd.user = {
    targets.sway-session = {
      description = "Sway compositor session";
      documentation = [ "man:systemd.special(7)" ];
      bindsTo = [ "graphical-session.target" ];
      wants = [ "graphical-session-pre.target" ];
      after = [ "graphical-session-pre.target" ];
    };
  };
}

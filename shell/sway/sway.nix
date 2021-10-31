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
      swappy
      waybar
      wf-recorder

      xorg.xlsclients
      xwayland
    ];

    systemd.user = {
      targets.sway-session = {
        description = "Sway compositor session";
        documentation = [ "man:systemd.special(7)" ];
        bindsTo = [ "graphical-session.target" ];
        wants = [ "graphical-session-pre.target" ];
        after = [ "graphical-session-pre.target" ];
      };

      services.sway = {
        description = "Sway - Wayland window manager";
        documentation = [ "man:sway(5)" ];
        bindsTo = [ "graphical-session.target" ];
        wants = [ "graphical-session-pre.target" ];
        after = [ "graphical-session-pre.target" ];
        # We explicitly unset PATH here, as we want it to be set by
        # systemctl --user import-environment in startsway
        environment.PATH = lib.mkForce null;
        serviceConfig = {
          Type = "simple";
          ExecStart = ''
            ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway --debug
          '';
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };
}

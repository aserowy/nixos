{ config, pkgs, ... }:
let
  swayConfig = pkgs.writeText "greeter-sway-config" ''
    exec "${pkgs.greetd.wlgreet}/bin/wlgreet --command sway; swaymsg exit"

    bindsym Mod4+q exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'

    exec "dbus-update-activation-environment --systemd --all; systemctl --user import-environment"
  '';
in
{
  environment.systemPackages = with pkgs; [
    greetd.wlgreet
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = pkgs.writeShellScript "greeter-sway" ''
          export PATH=${pkgs.sway}/bin:$PATH
          export LD_LIBRARY_PATH=${pkgs.wayland}/lib:${pkgs.libxkbcommon}/lib:$LD_LIBRARY_PATH

          ${pkgs.sway}/bin/sway --config ${swayConfig}
        '';
        user = "greeter";
      };
    };
    vt = 1;
  };
}

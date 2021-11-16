{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris
  ];

  systemd.user.extraConfig = ''
    DefaultLimitNOFILE=1048576
  '';

  systemd.extraConfig = ''
    DefaultLimitNOFILE=1048576
  '';
}

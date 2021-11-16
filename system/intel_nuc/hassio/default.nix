{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  systemd.services.hassio-docker-compose = {
    after = [ "docker.service" ];
    description = "hassio docker compose spin up";
    path = [ pkgs.bash ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose down";
      Restart = "on-failure";
      StartLimitIntervalSec = 60;
      StartLimitBurst = 3;
      TimeoutStartSec = 0;
      WorkingDirectory = "/srv";
    };
    requires = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
  };
}

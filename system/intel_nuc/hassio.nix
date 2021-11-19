{ config, pkgs, ... }:
let
  compose = pkgs.writeText "hassio-docker-compose" ''
    version: "3.0"
    services:
      ### home assistant
      mosquitto:
        image: eclipse-mosquitto:latest
        container_name: mosquitto
        restart: always
        ports:
          - "1883:1883"
          - "9001:9001"
        volumes:
          - /srv/mosquitto/config:/mosquitto/config
          - /srv/mosquitto/data:/mosquitto/data
          - /srv/mosquitto/log:/mosquitto/log

      zigbee2mqtt:
        image: koenkk/zigbee2mqtt:latest
        container_name: zigbee2mqtt
        restart: always
        environment:
          - TZ=Europe/Berlin
        depends_on:
          - mosquitto
        devices:
          - /dev/ttyAMA0:/dev/ttyAMA0
        ports:
          - "8124:8080"
        volumes:
          - /srv/zigbee2mqtt:/app/data
          - /run/udev:/run/udev:ro

      home-assistant:
        image: homeassistant/home-assistant:stable
        container_name: home-assistant
        restart: always
        network_mode: "host"
        depends_on:
          - zigbee2mqtt
        devices:
          - /dev/serial/by-id/usb-EnOcean_GmbH_EnOcean_USB_300_DC_FT50B8B0-if00-port0:/dev/serial/by-id/usb-EnOcean_GmbH_EnOcean_USB_300_DC_FT50B8B0-if00-port0
        volumes:
          - /srv/home-assistant:/config
          - /etc/localtime:/etc/localtime:ro

      ### pihole
      pihole:
        container_name: pihole
        image: pihole/pihole:latest
        ports:
          - "53:53/tcp"
          - "53:53/udp"
          - "67:67/udp"
          - "80:80/tcp"
        environment:
          TZ: 'Europe/Berlin'
          WEBPASSWORD: <pw>
        volumes:
          - /srv/pihole/:/etc/pihole/
          - /srv/dnsmasq.d/:/etc/dnsmasq.d/
        cap_add:
          - NET_ADMIN
        restart: always

      ### monitor
      docker2mqtt:
        image: serowy/docker2mqtt:latest
        container_name: docker2mqtt
        restart: always
        depends_on:
          - mosquitto
        volumes:
          - /srv/docker2mqtt/config:/docker2mqtt/config
          - /srv/docker2mqtt/logs:/docker2mqtt/logs
          - /var/run/docker.sock:/var/run/docker.sock

      ### update
      watchtower:
        image: containrrr/watchtower:latest
        container_name: watchtower
        restart: always
        environment:
          - WATCHTOWER_CLEANUP=true
          - WATCHTOWER_INCLUDE_RESTARTING=true
          - WATCHTOWER_POLL_INTERVAL=82800
        volumes:
          - /etc/timezone:/etc/timezone:ro
          - /var/run/docker.sock:/var/run/docker.sock

  '';
in
{
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  systemd.services.hassio-docker-compose = {
    after = [ "docker.service" ];
    description = "hassio docker compose spin up";
    path = [ pkgs.bash ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose --file ${compose} up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose --file ${compose} down";
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

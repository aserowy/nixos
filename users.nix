{ config, pkgs, ... }:

{
  users = {
    users.serowy = {
      createHome = true;
      extraGroups = ["docker" "wheel" "video" "audio" "disk" "networkmanager"];
      group = "users";
      home = "/home/serowy";
      isNormalUser = true;
      uid = 1000;
    };
  };
}

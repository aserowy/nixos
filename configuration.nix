{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      mkpasswd
    ];
  };

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      powerline-fonts
      nerdfonts
    ];
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 2022 ];
      allowedUDPPorts = [ 53 ];
      allowPing = true;
    };
    useDHCP = false;
    interfaces.eno1.useDHCP = true;
    hostName = "desktop-nixos";
  };

  nix = {
    package = pkgs.nixFlakes;
    useSandbox = true;
    autoOptimiseStore = true;
    readOnlyStore = false;
    allowedUsers = [ "@wheel" ];
    trustedUsers = [ "@wheel" ];
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d --max-freed $((64 * 1024**3))";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  services = {
    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
      ports = [ 2022 ];
    };
  };

  system = {
    stateVersion = "21.05"; # Did you read the comment?
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      flake = "github:aserowy/nixos";
      flags = [
        "--recreate-lock-file"
        "--no-write-lock-file"
        "-L"
      ];
      dates = "daily";
    };
  };

  time.timeZone = "Europe/Berlin";

  users = {
    users.serowy = {
      createHome = true;
      extraGroups = [ "docker" "wheel" "video" "audio" "disk" "networkmanager" ];
      group = "users";
      home = "/home/serowy";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAoChM+zDcZalCCTTF4NTeNyBcrbLBs8b0vBTp/EW1nX serowy" ];
      shell = pkgs.zsh;
      uid = 1000;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      enableOnBoot = true;
    };
  };
}

{ config, pkgs, ... }:

{
  programs = {
    neovim.defaultEditor = true;
    ssh.startAgent = false;
    zsh.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      mkpasswd
    ];
  };
}

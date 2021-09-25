{ config, pkgs, ... }:

{
  programs = {
    neovim.defaultEditor = true;
    ssh.startAgent = false;
    zsh.enable = true;
  };

  systemPackages = with pkgs; [
    bind
    curl
    direnv
    firefox
    git
    mkpasswd
    nix-direnv
    unstable.nvim
  ];
}

{ config, pkgs, lib, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "agreety --cmd $SHELL";
        user = "greeter";
      };
    };
    vt = 1;
  };
}

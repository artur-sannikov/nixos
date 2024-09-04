{ config, pkgs, ... }:
{
  config = {
    virtualisation = {
      podman = {
        enable = true;
      };
    };
  };
}

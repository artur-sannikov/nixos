{ config, ... }:
{
  config = {
    virtualisation = {
      podman = {
        enable = true;
      };
    };
  };
}

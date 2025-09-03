{ pkgs, ... }:
{
  services = {
    tailscale = {
      enable = true;
      package = pkgs.tailscale;
      useRoutingFeatures = "client";
    };
  };
}

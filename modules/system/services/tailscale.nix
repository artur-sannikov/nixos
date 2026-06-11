{ pkgs, ... }:
{
  flake.modules.nixosModules.cli = {
    services = {
      tailscale = {
        enable = true;
        package = pkgs.tailscale;
        useRoutingFeatures = "client";
      };
    };
  };
}

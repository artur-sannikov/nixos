{ pkgs, ... }:
{
  flake.modules.homeModules.gui = {
    services = {
      nextcloud-client = {
        enable = true;
        package = pkgs.nextcloud-client;
      };
    };
  };
}

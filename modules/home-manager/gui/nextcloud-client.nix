{ pkgs-stable, ... }:
{
  services = {
    nextcloud-client = {
      enable = true;
      package = pkgs-stable.nextcloud-client;
    };
  };
}

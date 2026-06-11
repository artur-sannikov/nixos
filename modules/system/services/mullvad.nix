{ pkgs, ... }:
{
  flake.modules.nixosModules.mullvad-vpn = {
    services = {
      mullvad-vpn = {
        enable = true;
        package = pkgs.mullvad-vpn;
        settings = {
          animateMap = false;
        };
      };
    };
  };
}

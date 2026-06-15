{
  flake.modules.nixos.mullvad-vpn = { pkgs, ... }: {
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

{
  flake.modules.nixos.mullvad-vpn = {
    services = {
      mullvad-vpn = {
        enable = true;
        gui.enable = true;
      };
    };
  };
}

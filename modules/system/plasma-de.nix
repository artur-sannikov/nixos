{ lib, ... }:
{
  flake.modules.nixos.plasma-de = {
    services = {
      xserver = {
        enable = false;
      };
      displayManager = {
        plasma-login-manager = {
          enable = lib.mkDefault true;
        };
      };
      desktopManager = {
        plasma6 = {
          enable = true;
        };
      };
    };
  };
}

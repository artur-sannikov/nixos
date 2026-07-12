{ lib, ... }:
{
  flake.modules.nixos.plasma-de =
    { pkgs, ... }:
    {
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
      environment = {
        plasma6 = {
          excludePackages = with pkgs.kdePackages; [
            elisa
            konsole
            qrca
            plasma-browser-integration
          ];
        };
      };
    };
}

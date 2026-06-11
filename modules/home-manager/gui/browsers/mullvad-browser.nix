{ pkgs-stable, ... }:
{
  flake.modules.homeModules.gui = {
    home.packages = with pkgs-stable; [
      mullvad-browser
    ];
  };
}

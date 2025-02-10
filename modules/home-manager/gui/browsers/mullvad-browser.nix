{ pkgs-stable, ... }:
{
  home.packages = with pkgs-stable; [
    mullvad-browser
  ];
}

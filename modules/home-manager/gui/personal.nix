{ pkgs-unstable, ... }:

{
  imports = [
    ./common.nix
  ];
  # Personal apps
  home.packages = with pkgs-unstable; [
    audacity
    calibre
    protonmail-bridge-gui
    telegram-desktop
    signal-desktop
  ];
}

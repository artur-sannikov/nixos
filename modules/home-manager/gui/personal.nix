{ pkgs-unstable, ... }:

{
  imports = [
    ./common.nix
  ];
  # Personal apps
  home.packages = with pkgs-unstable; [
    calibre
    telegram-desktop
    signal-desktop
  ];
}

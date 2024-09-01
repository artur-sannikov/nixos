{ pkgs-unstable, ... }:

{
  imports = [
    ./common.nix
  ];
  # Personal apps
  home.packages = with pkgs-unstable; [
    telegram-desktop
    signal-desktop
  ];
}

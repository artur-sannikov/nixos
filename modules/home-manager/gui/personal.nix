{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./common.nix
    # ./shadow-nix.nix
  ];
  # Personal apps
  home.packages = with pkgs-unstable; [
    audacity
    calibre
    protonmail-bridge-gui
    telegram-desktop
    signal-desktop
    moonlight-qt
    rustdesk-flutter
    tor-browser
    veracrypt
  ];
}

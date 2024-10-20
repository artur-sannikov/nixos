{ pkgs-unstable, ... }:

{
  imports = [
    ./common.nix
    ./shadow-pc.nix
  ];
  # Personal apps
  home.packages = with pkgs-unstable; [
    audacity
    calibre
    protonmail-bridge-gui
    telegram-desktop
    signal-desktop
    moonlight-qt
    flacon
    picard
    rustdesk-flutter
    tor-browser
    kdePackages.konversation
    kdePackages.kcalc
    veracrypt
  ];
}

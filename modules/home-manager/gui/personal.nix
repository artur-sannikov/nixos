{ pkgs, pkgs-stable, ... }:

{
  imports = [
    ./common.nix
  ];
  # Personal apps
  home.packages =
    with pkgs;
    [
      audacity
      bitwarden-desktop
      kdePackages.kcalc
      kdePackages.konversation
      moonlight-qt
      monero-gui
      picard
      rustdesk-flutter
      telegram-desktop
      tor-browser
      veracrypt
    ]
    ++ (with pkgs-stable; [
      calibre
      flacon
      protonmail-bridge-gui
      signal-desktop
    ]);
}

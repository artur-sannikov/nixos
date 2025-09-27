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
      calibre
      kdePackages.kcalc
      kdePackages.konversation
      moonlight-qt
      monero-gui
      picard
      protonmail-bridge-gui
      rustdesk-flutter
      telegram-desktop
      tor-browser
      veracrypt
    ]
    ++ (with pkgs-stable; [
      flacon
      signal-desktop
    ]);
}

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
      calibre
      kdePackages.kcalc
      kdePackages.konversation
      moonlight-qt
      monero-gui
      picard
      protonmail-bridge-gui
      telegram-desktop
      tor-browser
      veracrypt
    ]
    ++ (with pkgs-stable; [
      rustdesk-flutter
      flacon
      signal-desktop
    ]);
}

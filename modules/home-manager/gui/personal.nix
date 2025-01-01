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
      element-desktop
      kdePackages.kcalc
      kdePackages.konversation
      moonlight-qt
      monero-gui
      picard
      protonmail-desktop
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

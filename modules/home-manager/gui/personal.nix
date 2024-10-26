{ pkgs-unstable, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./shadow-pc.nix
  ];
  # Personal apps
  home.packages =
    with pkgs-unstable;
    [
      audacity
      element-desktop
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
    ]
    ++ (with pkgs; [
      calibre
      protonmail-bridge-gui
    ]);
}

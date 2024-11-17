{ pkgs, pkgs-stable, ... }:

{
  imports = [
    ./common.nix
    # ./shadow-pc.nix
  ];
  # Personal apps
  home.packages =
    with pkgs;
    [
      audacity
      element-desktop
      telegram-desktop
      signal-desktop
      moonlight-qt
      picard
      protonmail-bridge-gui
      protonmail-bridge
      tor-browser
      kdePackages.konversation
      kdePackages.kcalc
      veracrypt
    ]
    ++ (with pkgs-stable; [
      calibre
      flacon
      rustdesk-flutter
    ]);
}

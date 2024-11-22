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
      kdePackages.kcalc
      kdePackages.konversation
      moonlight-qt
      picard
      protonmail-bridge
      protonmail-bridge-gui
      rustdesk-flutter
      signal-desktop
      telegram-desktop
      tor-browser
      veracrypt
    ]
    ++ (with pkgs-stable; [
      calibre
      flacon
    ]);
}

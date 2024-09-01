<<<<<<< HEAD
# Common GUI apps without special settings
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mattermost-desktop
    freetube
    zotero
    onlyoffice-bin_latest
    libreoffice

    vlc
  ];
||||||| bb21092
=======
# GUI apps without special settings
{
  pkgs-stable,
  pkgs-unstable,
  flake-inputs,
  ...
}:
{
  home.packages =
    (with pkgs-stable; [
      betterbird
      obsidian
      vlc
      qbittorrent
      mattermost-desktop
      protonvpn-gui
      freetube
      libreoffice-qt6-fresh
      onlyoffice-bin
    ])
    ++ (with pkgs-unstable; [
      zotero
    ]);
  # GUI apps with special settings
  imports = [
    ./browsers/firefox.nix
    ./browsers/librewolf.nix
    ./vscodium.nix
    ./syncthing.nix
  ];
  # Flatapks
  # services.flatpak = {
  #   enable = true;
  #   update.onActivation = true;
  #   packages = [
  #     "it.mijorus.gearlever"
  #     {
  #       appId = "us.zoom.Zoom";
  #       origin = "flathub";
  #       commit = "b9505f108b5f9acb2bbad83ac66f97b42bc6a75b9c28ed7b75dec1040e013305";
  #     } # Screen sharing is broken on Plasma on newer versions
  #   ];
  # };
>>>>>>> ca7c6432045bdcc03ab48f88fa45bba478ab6991
}

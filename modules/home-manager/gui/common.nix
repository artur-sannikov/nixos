# GUI apps without special settings
{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages =
    (with pkgs; [
      betterbird
      obsidian
      vlc
      qbittorrent
      mattermost-desktop
      # protonvpn-gui
      # freetube
      # libreoffice-qt6-fresh
      # onlyoffice-bin
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
}
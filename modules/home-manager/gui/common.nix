# GUI apps without special settings
{
  pkgs,
  pkgs-unstable,
  ...
}:
{

  home.packages =
    (with pkgs; [
      obsidian
      vlc
      qbittorrent
      mattermost-desktop
      inkscape
      # protonvpn-gui
      # freetube
      libreoffice-qt6-fresh
      hunspell
      hunspellDicts.en_GB-large
      onlyoffice-bin
    ])
    ++ (with pkgs-unstable; [
      # betterbird
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

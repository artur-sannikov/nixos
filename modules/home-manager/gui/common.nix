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
      protonvpn-gui
      freetube
      libreoffice-qt6-fresh
      hunspell
      hunspellDicts.en_GB-large
      onlyoffice-bin
      okular
      texlive.combined.scheme-medium
      texstudio
      haruna
    ])
    ++ (with pkgs-unstable; [
      zotero
    ]);
  # GUI apps with special settings
  imports = [
    ./browsers/firefox.nix
    ./browsers/librewolf.nix
    ./browsers/brave.nix
    ./vscodium.nix
    ./syncthing.nix
    ./thunderbird.nix
    ./fonts.nix
  ];
}

# GUI apps without special settings
{
  pkgs,
  pkgs-stable,
  ...
}:
{

  home.packages =
    (with pkgs-stable; [
      feishin
      haruna
      hunspell
      hunspellDicts.en_GB-large
      inkscape
      libreoffice-qt6-fresh
      obsidian
      okular
      protonvpn-gui
      strawberry-qt6
      texlive.combined.scheme-medium
      texstudio
      vlc
      zoom-us
    ])
    ++ (with pkgs; [
      anki
      mattermost-desktop
      freetube
      gearlever
      onlyoffice-desktopeditors
      qbittorrent
      zotero
    ]);
  # GUI apps with special settings
  imports = [
    ./browsers/firefox.nix
    ./browsers/librewolf.nix
    ./browsers/brave.nix
    ./vscodium.nix
    ./thunderbird.nix
    # ./fonts.nix
  ];
}

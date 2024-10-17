# GUI apps without special settings
{
  pkgs,
  pkgs-unstable,
  ...
}:
{

  home.packages =
    (with pkgs; [
      feishin
      freetube
      haruna
      hunspell
      hunspellDicts.en_GB-large
      inkscape
      libreoffice-qt6-fresh
      mattermost-desktop
      obsidian
      okular
      protonvpn-gui
      qbittorrent
      strawberry-qt6
      texlive.combined.scheme-medium
      texstudio
      vlc
      zoom-us
    ])
    ++ (with pkgs-unstable; [
      gearlever
      onlyoffice-desktopeditors
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

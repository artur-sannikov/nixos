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
      feishin
      strawberry-qt6
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
      zoom-us
    ])
    ++ (with pkgs-unstable; [
      gearlever
      zotero
    ]);
  # GUI apps with special settings
  imports = [
    ./browsers/firefox.nix
    ./browsers/librewolf.nix
    ./browsers/brave.nix
    ./vscodium.nix
    ./thunderbird.nix
    ./fonts.nix
  ];
}

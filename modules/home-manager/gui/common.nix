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
      gearlever
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

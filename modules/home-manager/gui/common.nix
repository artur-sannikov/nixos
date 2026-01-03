# GUI apps without special settings
{
  pkgs,
  pkgs-stable,
  ...
}:
{

  home.packages =
    (with pkgs-stable; [
      element-desktop
      haruna
      hunspell
      hunspellDicts.en_GB-large
      inkscape
      kdePackages.filelight
      kdePackages.okular
      libreoffice-qt-fresh
      obsidian
      protonvpn-gui
      strawberry
      texstudio
      tidal-hifi
      vlc
    ])
    ++ (with pkgs; [
      anki
      freetube
      gearlever
      mattermost-desktop
      meld
      onlyoffice-desktopeditors
      qbittorrent
      zotero
    ]);
  # GUI apps with special settings
  imports = [
    ./browsers
    ./email.nix
    ./keepassxc.nix
    ./kitty.nix
    ./mpv.nix
    ./nextcloud-client.nix
  ];
}

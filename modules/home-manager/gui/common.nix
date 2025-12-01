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
      rclone
      strawberry
      texstudio
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
      texlive.combined.scheme-full
      tidal-hifi
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
    ./vscodium.nix
  ];
}

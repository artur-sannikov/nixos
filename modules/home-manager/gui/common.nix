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
      hunspell
      hunspellDicts.en_GB-large
      inkscape
      kdePackages.filelight
      kdePackages.okular
      libreoffice-qt-fresh
      obsidian
      protonvpn-gui
      texstudio
      tidal-hifi
      vlc
    ])
    ++ (with pkgs; [
      anki
      bitwarden-desktop
      freetube
      gearlever
      mattermost-desktop
      meld
      onlyoffice-desktopeditors
      qbittorrent
      zotero
      zulip
    ]);
  # GUI apps with special settings
  imports = [
    ./browsers
    ./keepassxc.nix
    ./kitty.nix
    ./mpv.nix
    ./nextcloud-client.nix
  ];
}

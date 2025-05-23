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
      libreoffice-qt6-fresh
      obsidian
      protonvpn-gui
      rclone
      strawberry-qt6
      texlive.combined.scheme-medium
      texstudio
      vlc
      zoom-us
    ])
    ++ (with pkgs; [
      anki
      freetube
      gearlever
      mattermost-desktop
      onlyoffice-desktopeditors
      qbittorrent
      tidal-hifi
      seafile-client
      zotero
    ]);
  # GUI apps with special settings
  imports = [
    ./browsers/firefox.nix
    ./browsers/librewolf.nix
    ./browsers/brave.nix
    ./browsers/mullvad-browser.nix
    ./vscodium.nix
    ./thunderbird.nix
    ./mpv.nix
  ];
}

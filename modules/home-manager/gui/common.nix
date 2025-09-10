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
      texlive.combined.scheme-full
      tidal-hifi
      zotero
    ]);
  # GUI apps with special settings
  imports = [
    ./browsers/firefox.nix
    ./browsers/librewolf.nix
    ./browsers/brave.nix
    ./browsers/mullvad-browser.nix
    ./nextcloud-client.nix
    ./vscodium.nix
    ./email.nix
    ./mpv.nix
    ./keepassxc.nix
  ];
}

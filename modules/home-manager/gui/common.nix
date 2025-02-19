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
      # feishin
      freetube
      gearlever
      mattermost-desktop
      onlyoffice-desktopeditors
      qbittorrent
      zotero
    ]);
  # GUI apps with special settings
  imports = [
    # ./browsers/firefox.nix # Disable firefox due to https://github.com/nix-community/home-manager/issues/6467
    ./browsers/librewolf.nix
    ./browsers/brave.nix
    ./browsers/mullvad-browser.nix
    ./vscodium.nix
    ./thunderbird.nix
    ./mpv.nix
    # ./fonts.nix
  ];
}

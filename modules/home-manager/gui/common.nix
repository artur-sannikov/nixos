# GUI apps without special settings
{
  pkgs-stable,
  pkgs,
  ...
}:
{

  home.packages =
    (with pkgs-stable; [
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
      onlyoffice-bin
      protonvpn-gui
      qbittorrent
      strawberry-qt6
      texlive.combined.scheme-medium
      texstudio
      vlc
      zoom-us
    ])
    ++ (with pkgs; [
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
    ./neovim.nix
  ];
}

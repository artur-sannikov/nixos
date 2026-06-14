# GUI apps without special settings
{
  flake.modules.homeManager.gui =
    {
      pkgs,
      pkgs-stable,
      ...
    }:
    {
      home.packages =
        (with pkgs-stable; [
          anki
          hunspell
          hunspellDicts.en_GB-large
          inkscape
          kdePackages.filelight
          kdePackages.kcalc
          kdePackages.okular
          libreoffice-qt-fresh
        ])
        ++ (with pkgs; [
          mattermost-desktop
          obsidian
          onlyoffice-desktopeditors
          qbittorrent
          seafile-client
          texstudio
          vlc
          zotero
        ]);
    };
}

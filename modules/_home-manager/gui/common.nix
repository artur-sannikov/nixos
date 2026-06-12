# GUI apps without special settings
{
  flake.modules.homeModules.gui =
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
          kdePackages.okular
          libreoffice-qt-fresh
          obsidian
          texstudio
          vlc
        ])
        ++ (with pkgs; [
          mattermost-desktop
          onlyoffice-desktopeditors
          qbittorrent
          seafile-client
          zotero
          # zulip
        ]);
    };
}

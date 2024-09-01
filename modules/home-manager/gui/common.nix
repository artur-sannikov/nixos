# Common GUI apps without special settings
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mattermost-desktop
    freetube
    zotero
    onlyoffice-bin_latest
    libreoffice

    vlc
  ];
}

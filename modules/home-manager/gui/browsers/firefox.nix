{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles.default-release.settings = {
      "browser.toolbars.bookmarks.visibility" = "always";
      "privacy.clearOnShutdown.history" = true;
      "privacy.clearOnShutdown.cookies" = true;
      "privacy.clearOnShutdown.downloads" = true;
      "privacy.clearOnShutdown.openWindows" = true;
    };
  };
}
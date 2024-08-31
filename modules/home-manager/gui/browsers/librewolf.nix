{ pkgs, ... }:
{
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf-wayland;
    settings = {
      "browser.toolbars.bookmarks.visibility" = "always";
      "privacy.clearOnShutdown.history" = true;
      "privacy.clearOnShutdown.cookies" = true;
      "privacy.clearOnShutdown.downloads" = true;
      "privacy.clearOnShutdown.openWindows" = true;
    };
  };
}

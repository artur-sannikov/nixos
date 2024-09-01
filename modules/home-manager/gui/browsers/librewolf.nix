{ pkgs-stable, ... }:
{
  programs.librewolf = {
    enable = true;
    package = pkgs-stable.librewolf-wayland;
    settings = {
      "browser.toolbars.bookmarks.visibility" = "always";
      "privacy.clearOnShutdown.history" = true;
      "privacy.clearOnShutdown.cookies" = true;
      "privacy.clearOnShutdown.downloads" = true;
      "privacy.clearOnShutdown.openWindows" = true;
    };
  };

  # Set default browser to librewolf
  xdg.mimeApps.defaultApplications = {
    "text/html" = "librewolf.desktop";
    "x-scheme-handler/http" = "librewolf.desktop";
    "x-scheme-handler/https" = "librewolf.desktop";
    "x-scheme-handler/about" = "librewolf.desktop";
    "x-scheme-handler/unknown" = "librewolf.desktop";
  };
}

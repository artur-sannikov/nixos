{ pkgs, ... }:
{
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf;
    settings = {
      # "browser.toolbars.bookmarks.visibility" = "always";
      # "privacy.clearOnShutdown.history" = true;
      # "privacy.clearOnShutdown.cookies" = true;
      # "privacy.clearOnShutdown.downloads" = true;
      # "privacy.clearOnShutdown.openWindows" = true;

      # # Enable Firefox sync
      # "identity.fxaccounts.enabled" = true;

      # "network.trr.mode" = 2;
      # "network.trr.uri" = "https://base.dns.mullvad.net/dns-query";
      # };
    };
  };

  # TODO
  # Librewolf is currently half-broken (see https://codeberg.org/librewolf/issues/issues/2040)
  # It does not respect `settings` option and resets DNS to Mozilla after every restart
  # Also in nixpkgs the default engine is Google (see https://github.com/NixOS/nixpkgs/issues/338439)
  home.file = {
    ".librewolf/librewolf.overrides.cfg".source = ./librewolf.overrides.cfg;
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

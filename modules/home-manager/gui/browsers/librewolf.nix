{ pkgs, ... }:
{
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf;
    settings = {
      "browser.toolbars.bookmarks.visibility" = "always";
      "privacy.clearOnShutdown.history" = true;
      "privacy.clearOnShutdown.cookies" = true;
      "privacy.clearOnShutdown.downloads" = true;
      "privacy.clearOnShutdown.openWindows" = true;

      # Enable Firefox sync
      "identity.fxaccounts.enabled" = true;

      "network.trr.mode" = 2;
      "network.trr.uri" = "https://base.dns.mullvad.net/dns-query";

      "security.ssl.enable_ocsp_must_staple" = false;
    };
  };
}

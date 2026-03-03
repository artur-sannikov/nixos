{ pkgs, ... }:
let
  settings = {
    # Enable Firefox sync
    "identity.fxaccounts.enabled" = true;

    "network.trr.mode" = 2;
    "network.trr.uri" = "https://base.dns.mullvad.net/dns-query";

    "security.ssl.enable_ocsp_must_staple" = false;

    "browser.tabs.insertAfterCurrent" = true;
    "browser.tabs.warnOnClose" = true;
  };
in
{
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf;
    profiles = {
      default = { inherit settings; };
      work = {
        id = 1;
        inherit settings;
      };
    };
    policies = {

      # Not needed with Vimium
      DisplayBookmarksToolbar = "never";
      # Language
      # https://mozilla.github.io/policy-templates/#requestedlocales
      RequestedLocales = [
        "fi"
        "en-US"
      ];

      # https://mozilla.github.io/policy-templates/#sanitizeonshutdown-all
      # Delete all data on shutdown
      SanitizeOnShutdown = true;

      # https://mozilla.github.io/policy-templates/#httpsonlymode
      HttpsOnlyMode = "force_enabled";

      # https://mozilla.github.io/policy-templates/#disableformhistory
      DisableFormHistory = true;

      TranslateEnabled = true;
    };
  };
  stylix.targets.librewolf.profileNames = [
    "default"
  ];
}

{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    # Use arkenfox hardening
    autoConfigFiles = [ "${pkgs.arkenfox-userjs}/user.cfg" ];
    languagePacks = [
      "en-US"
      "fi"
    ];
    # https://mozilla.github.io/policy-templates/
    policies = {
      DontCheckDefaultBrowser = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;

      # https://mozilla.github.io/policy-templates/#sanitizeonshutdown-all
      # Delete all data on shutdown
      SanitizeOnShutdown = true;

      # https://mozilla.github.io/policy-templates/#httpsonlymode
      HttpsOnlyMode = "force_enabled";

      # https://mozilla.github.io/policy-templates/#disableformhistory
      DisableFormHistory = true;

      DisplayBookmarksToolbar = "always";
      TranslateEnabled = true;

      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = false;
        MoreFromMozilla = false;
      };

      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };

      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };

      # Disable password save offer
      OfferToSaveLogins = false;

      # https://mozilla.github.io/policy-templates/#dnsoverhttps
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://base.dns.mullvad.net/dns-query";
        Locked = true;
        FallBack = true;
      };
    };
  };
}

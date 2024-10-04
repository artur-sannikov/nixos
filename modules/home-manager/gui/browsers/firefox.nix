{ pkgs, flake-inputs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    # https://mozilla.github.io/policy-templates/
    policies = {
      DontCheckDefaultBrowser = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;

      DisplayBookmarksToolbar = "always";
      TranslateEnabled = true;
      RequestedLocales = "en-GB,fi,ru,it";

      SanitizeOnShutdown = true;

      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        Locked = true;
      };

      EnableTrackingProtection = {
        Value = true;
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

      # https://mozilla.github.io/policy-templates/#dnsoverhttps
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://base.dns.mullvad.net/dns-query";
        Locked = true;
        FallBack = true;
      };

      Preferences = {
        browser.warnOnQuitShortcut = true;

        # Privacy
        browser.sessionstore.privacy_level = 2;
        privacy.clearOnShutdown.openWindows = true;
      };
    };

    languagePacks = [
      "en-GB"
      "ru"
      "fi"
      "it"
    ];

    profiles = {
      default-release = {
        extensions = with flake-inputs.firefox-extensions.packages.${pkgs.system}; [
          ublock-origin
          bitwarden
          libredirect
        ];
        search = {
          force = true;
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
        };
      };
    };
  };
}

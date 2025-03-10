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

      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = false;
        MoreFromMozilla = false;
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
      };

    };
    profiles = {
      default-release = {
        extensions.packages = with flake-inputs.firefox-extensions.packages.${pkgs.system}; [
          ublock-origin
          bitwarden
          libredirect
        ];
        search = {
          force = true;
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
        };
        settings = {
          "privacy.clearOnShutdown.history" = true;
          "privacy.clearOnShutdown.cookies" = true;
          "privacy.clearOnShutdown.downloads" = true;
          "privacy.clearOnShutdown.openWindows" = true;
          "privacy.clearOnShutdown.offlineApps" = true;
        };
      };
      tidal-hifi = {
        isDefault = false;
        id = 1;
        bookmarks = [
          {
            name = "tidal";
            url = "https://listen.tidal.com/";
          }
        ];
        extensions.packages = with flake-inputs.firefox-extensions.packages.${pkgs.system}; [
          ublock-origin
        ];
        search = {
          force = true;
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
        };
        settings = {
          "privacy.clearOnShutdown.history" = true;
          "privacy.clearOnShutdown.cookies" = false;
          "privacy.clearOnShutdown.downloads" = true;
          "privacy.clearOnShutdown.openWindows" = false;
          "privacy.clearOnShutdown.offlineApps" = true;
        };
      };
    };
  };
}

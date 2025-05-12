{ pkgs, flake-inputs, ... }:
let
  firefoxProfileSettings = {
    "privacy.clearOnShutdown.history" = true;
    "privacy.clearOnShutdown.cookies" = true;
    "privacy.clearOnShutdown.downloads" = true;
    "privacy.clearOnShutdown.openWindows" = true;
    "privacy.clearOnShutdown.offlineApps" = true;
    "privacy.resistFingerprinting" = true;
    "privacy.firsttparty.isolate" = true;
    "geo.enabled" = false;
  };
in
{
  programs.firefox = {
    enable = true;
    # https://mozilla.github.io/policy-templates/
    policies = {
      DontCheckDefaultBrowser = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;

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

      Preferences =
        builtins.mapAttrs
          (name: value: {
            Value = value;
            Status = "locked";
          })
          {
            "browser.warnOnQuitShortcut" = true;
            "browser.tabs.warnOnClose" = true;
            "browser.sessionstore.privacy_level" = 2;
          };
    };

    profiles = {
      default-release = {
        extensions.packages = with flake-inputs.firefox-extensions.packages.${pkgs.system}; [
          ublock-origin
          bitwarden
          libredirect
          darkreader
        ];
        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";
        };
        settings = firefoxProfileSettings;
      };
      tidal-hifi = {
        isDefault = false;
        id = 1;
        bookmarks = {
          force = true;
          settings = [
            {
              name = "tidal";
              url = "https://listen.tidal.com/";
            }
          ];
        };
        extensions.packages = with flake-inputs.firefox-extensions.packages.${pkgs.system}; [
          ublock-origin
          bitwarden
        ];
        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";
        };
        settings = firefoxProfileSettings;
      };
    };
  };
}

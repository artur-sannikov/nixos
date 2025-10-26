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

            # Disable that websites can get notifications if you copy or paste
            "dom.event.clipboardevents.enabled" = true;

            # Disable all telemetry
            # See https://github.com/K3V1991/Disable-Firefox-Telemetry-and-Data-Collection
            # Some entries do not exist anymore
            # Search for more info https://searchfox.org/firefox-main
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;
            "datareporting.healthreport.service.enabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.bhrPing.enabled" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.reportingpolicy.firstRun" = false;
            "toolkit.telemetry.server" = "";
            "toolkit.telemetry.shutdownPingSender.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.updatePing.enabled" = false;
            "breakpad.reportURL" = "";
            "browser.tabs.crashReporting.sendReport" = false;
            "beacon.enabled" = false;

            # Disable Firefox experiments
            "extensions.experiments.enabled" = false;
          };
    };

    profiles = {
      default-release = {
        isDefault = true;
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
  stylix.targets.firefox.profileNames = [
    "default-release"
  ];
}

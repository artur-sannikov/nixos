{ pkgs, lib, ... }:
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
      ExtensionSettings =
        let
          moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
        in
        {
          "uBlock0@raymondhill.net" = {
            default_area = "menupanel";
            install_url = moz "ublock-origin";
            installation_mode = "force_installed";
            private_browsing = true;
            updates_disabled = true;
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            default_area = "menupanel";
            install_url = moz "bitwarden-password-manager";
            installation_mode = "force_installed";
            private_browsing = false;
            updates_disabled = true;
          };
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
            default_area = "navbar";
            install_url = moz "vimium-ff";
            installation_mode = "force_installed";
            private_browsing = true;
            updates_disabled = true;
          };
        };
      "3rdparty".Extensions = {
        "uBlock0@raymondhill.net".adminSettings = {
          userSettings = rec {
            uiTheme = "dark";
            uiAccentCustom = true;
            uiAccentCustom0 = "#8300ff";
            cloudStorageEnabled = true;

            importedLists = [
              "https:#filters.adtidy.org/extension/ublock/filters/3.txt"
              "https:#github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
            ];

            externalLists = lib.concatStringsSep "\n" importedLists;
          };

          selectedFilterLists = [
            "ublock-filters"
            "ublock-badware"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "easylist"
            "easyprivacy"
            "adguard-spyware-url"
            "urlhaus-1"
            "plowe-0"
            "fanboy-cookiemonster"
            "ublock-cookies-easylist"
            "fanboy-social"
            "fanboy-ai-suggestions"
            "easylist-chat"
            "easylist-newsletters"
            "easylist-notifications"
            "easylist-annoyances"
            "ublock-annoyances"
            "FIN-0"
            "RUS-0"
            "RUS-1"
          ];
        };
      };
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

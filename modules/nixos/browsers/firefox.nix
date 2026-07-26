{
  flake.modules.nixos.gui = { pkgs, ... }: {
    programs.firefox = {
      enable = true;
      # Use arkenfox hardening
      autoConfigFiles = [ "${pkgs.arkenfox-userjs}/user.cfg" ];
      preferences = {
        # Disable menu pop-up at alt press
        "ui.key.menuAccessKeyFocuses" = false;
      };
      languagePacks = [
        "fi"
        "en-US"
      ];
      # https://mozilla.github.io/policy-templates/
      policies = {
        DontCheckDefaultBrowser = true;
        DisableTelemetry = true;
        DisableFirefoxStudies = true;

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

        DisplayBookmarksToolbar = "always";
        TranslateEnabled = true;

        # https://mozilla.github.io/policy-templates/#promptfordownloadlocation
        PromptForDownloadLocation = true;

        # https://mozilla.github.io/policy-templates/#usermessaging
        UserMessaging = {
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          UrlbarInterventions = false;
          SkipOnboarding = false;
          MoreFromMozilla = false;
          FirefoxLabs = false;
          Locked = true;
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
          Stories = false;
          SponsoredStories = false;
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

        # Disable all AI features
        GenerativeAI = {
          Enabled = false;
          Locked = true;
        };
        Preferences = {
          "browser.download.deletePrivate" = true;
          "browser.download.deletePrivate.chosen" = true;
        };
      };
    };
  };
}

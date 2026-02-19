let
  braveExtensions = [
    "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
    "nngceckbapebfimnlniiiahkandclblb" # bitwarden
    "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
  ];
in
{
  programs = {
    chromium = {
      enable = true;
      extensions = braveExtensions;
      defaultSearchProviderEnabled = true;
      defaultSearchProviderSearchURL = "https://noai.duckduckgo.com/?q={searchTerms}";
      # https://chromeenterprise.google/policies/
      extraOpts = {
        # Search options
        DefaultSearchProviderName = "DuckDuckGo";
        DefaultSearchProviderKeyword = "ddg";
        DefaultSerialGuardSetting = 2;
        SyncDisabled = true;
        PasswordManagerEnabled = false;
        PasswordSharingEnabled = false;
        PasswordLeakDetectionEnabled = false;
        SafeBrowsingExtendedReportingEnabled = false;
        SafeBrowsingSurveysEnabled = false;
        ClearBrowsingDataOnExitList = [
          "browsing_history"
          "download_history"
          "cookies_and_other_site_data"
          "cached_images_and_files"
          "password_signin"
          "autofill"
          "site_settings"
          "hosted_app_data"
        ];
        BlockThirdPartyCookies = true;

        # Security
        # https://github.com/RKNF404/chromium-hardening-guide/blob/main/configs/Configuration.config
        HttpsOnlyMode = "force_enabled";
        DnsOverHttpsMode = "automatic";
        ExtensionInstallAllowlist = braveExtensions;
        ExtensionInstallBlocklist = [ "*" ]; # Block all extensions by default
        RemoteAccessHostAllowRemoteAccessConnections = false;
        RemoteAccessHostFirewallTraversal = false;
        RemoteDebuggingAllowed = false;
        PaymentMethodQueryEnabled = false;

        # Privacy
        DefaultGeolocationSetting = 2;
        DefaultNotificationsSetting = 2;
        DefaultLocalFontsSetting = 2;
        AIModeSettings = 1; # Disable AI integrations
        DevToolsGenAiSettings = 2; # Disable LLM in debugging
        DefaultSensorsSetting = 2;
        EnableMediaRouter = false; # Disable Chrome Cast
        PromotionsEnabled = false;
        SpellCheckServiceEnabled = false; # Disables Google spellcheck service
        UrlKeyedAnonymizedDataCollectionEnabled = false;
        UserFeedbackAllowed = false;

        # Miscellaneous
        AlternateErrorPagesEnabled = false;
        AutofillCreditCardEnabled = false;
        BackgroundModeEnabled = false;
        BrowserGuestModeEnabled = false;
        BrowserSignin = 0;
        BuiltInDnsClientEnabled = false;
        DefaultBrowserSettingEnabled = false;
        MetricsReportingEnabled = false;
        ShoppingListEnabled = false;
        AlwaysOpenPdfExternally = true;
        TranslateEnabled = false; # Don't really use it
        LiveTranslateEnabled = false;
        RestoreOnStartup = 4; # Show list of URLs
        HomepageIsNewTabPage = true;
        NewTabPageLocation = "https://noai.duckduckgo.com";
        RestoreOnStartupURLs = [
          "https://noai.duckduckgo.com"
        ];
        ForcedLanguages = [
          "fi"
          "en-US"
        ];
        SpellcheckLanguage = [
          "it"
          "en-US"
        ];
        # Brave stuff
        BraveAIChatEnabled = false;
        BraveNewsDisabled = true;
        BraveP3AEnabled = false;
        BraveRewardsDisabled = true;
        BraveSpeedreaderEnabled = false;
        BraveStatsPingEnabled = false;
        BraveSyncUrl = "";
        BraveTalkDisabled = true;
        BraveVPNDisabled = true;
        BraveWalletDisabled = true;
        BraveWaybackMachineEnabled = false;
        BraveWebDiscoveryEnabled = false;
        TorDisabled = true;
        BravePlaylistEnabled = false;
      };
    };
  };
}

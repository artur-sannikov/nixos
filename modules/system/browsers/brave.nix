{
  programs = {
    chromium = {
      enable = true;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        "nngceckbapebfimnlniiiahkandclblb" # bitwarden
        "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      ];
      enablePlasmaBrowserIntegration = true;
      defaultSearchProviderEnabled = true;
      defaultSearchProviderSearchURL = "https://noai.duckduckgo.com/?q=";
      extraOpts = {
        # Search options
        "DefaultSearchProviderName" = "DuckDuckGo";
        "DefaultSearchProviderKeyword" = "ddg";
        # Content Settings
        "DefaultGeolocationSetting" = 2;
        "DefaultNotificationsSetting" = 2;
        "DefaultLocalFontsSetting" = 2;
        "DefaultSensorsSetting" = 2;
        "DefaultSerialGuardSetting" = 2;
        "SyncDisabled" = true;
        "PasswordManagerEnabled" = false;
        "PasswordSharingEnabled" = false;
        "PasswordLeakDetectionEnabled" = false;
        "SafeBrowsingExtendedReportingEnabled" = false;
        "SafeBrowsingSurveysEnabled" = false;
        # User and device reporting
        "DeviceActivityHeartbeatEnabled" = false;
        "DeviceMetricsReportingEnabled" = false;
        "HeartbeatEnabled" = false;
        "LogUploadEnabled" = false;
        "ReportAppInventory" = "";
        "ReportDeviceActivityTimes" = false;
        "ReportDeviceAppInfo" = false;
        "ReportDeviceSystemInfo" = false;
        "ReportDeviceUsers" = false;
        "ReportWebsiteTelemetry" = "";
        # Quick Answers
        "QuickAnswersEnabled" = false;
        # Miscellaneous
        "AlternateErrorPagesEnabled" = false;
        "AutofillCreditCardEnabled" = false;
        "BackgroundModeEnabled" = false;
        "BrowserGuestModeEnabled" = false;
        "BrowserSignin" = 0;
        "BuiltInDnsClientEnabled" = false;
        "DefaultBrowserSettingEnabled" = false;
        "MetricsReportingEnabled" = false;
        "ParcelTrackingEnabled" = false;
        "RelatedWebsiteSetsEnabled" = false;
        "ShoppingListEnabled" = false;
        "WarnBeforeQuittingEnabled" = true;
        "AlwaysOpenPdfExternally" = true;
        "SpellcheckLanguage" = [
          "fi"
          "it"
          "en-US"
        ];
        # Brave stuff
        "BraveAIChatEnabled" = false;
        "BraveNewsDisabled" = true;
        "BraveP3AEnabled" = false;
        "BraveRewardsDisabled" = true;
        "BraveSpeedreaderEnabled" = false;
        "BraveStatsPingEnabled" = false;
        "BraveSyncUrl" = "";
        "BraveTalkDisabled" = true;
        "BraveVPNDisabled" = true;
        "BraveWalletDisabled" = true;
        "BraveWaybackMachineEnabled" = false;
        "BraveWebDiscoveryEnabled" = false;
        "TorDisabled" = true;
        "BravePlaylistEnabled" = false;
      };
    };
  };
}

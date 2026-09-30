{
  flake.modules.homeManager.gui =
    { config, pkgs, ... }:
    let
      settings = {
        # Enable Firefox sync
        "identity.fxaccounts.enabled" = true;

        # Enable backup
        "browser.backup.scheduled.enabled" = true;
        "browser.backup.location" = "${config.xdg.userDirs.documents}/Restore Firefox";

        # Disable menu pop-up at alt press
        "ui.key.menuAccessKeyFocuses" = false;

        "security.ssl.enable_ocsp_must_staple" = false;

        "browser.tabs.insertAfterCurrent" = true;
        "browser.tabs.warnOnClose" = true;
      };
    in
    {
      programs = {
        librewolf = {
          enable = true;
          package = pkgs.stable.librewolf;
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

            # https://mozilla.github.io/policy-templates/#translateenabled
            TranslateEnabled = true;

            # https://mozilla.github.io/policy-templates/#promptfordownloadlocation
            PromptForDownloadLocation = true;

            # Disable password save offer
            OfferToSaveLogins = false;

            Preferences = {
              "browser.download.deletePrivate" = true; # Delete private window downloads on close
              "browser.download.deletePrivate.chosen" = true;
            };
          };
        };
      };
      stylix = {
        targets = {
          librewolf = {
            profileNames = [
              "default"
            ];
          };
        };
      };
    };
}

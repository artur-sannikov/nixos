# Create a dedicated "archive" profile for old email accounts
{
  flake.modules.homeManager.email-personal = {
    programs = {
      thunderbird = {
        enable = true;
        profiles = {
          archive = {
            isDefault = false;
            # Recommended settings for the archive profile are here:
            # https://firewallsdontstopdragons.com/download-all-your-emails/
            settings = {
              "mail.accounthub.thundermail.enabled" = false;

              # For references see:
              #   https://wiki.mozilla.org/index.php?title=Thunderbird%2FMaildir
              #   https://blog.jj5.net/blog/2017/05/14/thunderbird-maildir-backend/
              #   https://access.redhat.com/articles/6167512
              "mail.serverDefaultStoreContractID" = "@mozilla.org/msgstore/maildirstore;1";

              # Download messages for offline use when going offline? = Yes
              "offline.download.download_messages" = 1;

              # Send unsent messages when going online? = No
              "offline.send.unsent_messages" = 2;

              # Do not sell or share data
              "privacy.globalprivacycontrol.enabled" = true;
              "privacy.donottrackheader.enabled" = true;

              # Disable remote content
              "mailnews.message_display.disable_remote_image" = true;

              # Enable DNS-over-HTTPS (DoH) - Increased protection
              "network.trr.mode" = 2;

              # Disable Telemetry
              # See https://github.com/HorlogeSkynet/thunderbird-user.js/blob/master/user.js#L1225
              "datareporting.healthreport.uploadEnabled" = false;
              "toolkit.telemetry.unified" = false;
              "toolkit.telemetry.enabled" = false;
              "toolkit.telemetry.server" = "data:=";
              "toolkit.telemetry.archive.enabled" = false;
              "toolkit.telemetry.newProfilePing.enabled" = false;
              "toolkit.telemetry.shutdownPingSender.enabled" = false;
              "toolkit.telemetry.updatePing.enabled" = false;
              "toolkit.telemetry.bhrPing.enabled" = false;
              "toolkit.telemetry.firstShutdownPing.enabled" = false;
            };
          };
        };
      };
    };
  };
}

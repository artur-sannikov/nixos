{
  flake.modules.homeManager.email =
    { pkgs, ... }:
    let
      commonSettings = {
        # Do not accept third-party cookies
        "network.cookie.cookieBehavior" = 1;

        # Do not sell or share data
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.donottrackheader.enabled" = true;

        # Disable remote contente
        "mailnews.message_display.disable_remote_image" = true;
      };
    in
    {
      accounts = {
        email = {
          accounts = {
            work = {
              thunderbird = {
                enable = true;
                profiles = [ "work" ];
                settings = id: {
                  "mail.server.server_${id}.authMethod" = 3;
                };
              };
            };
            migadu = {
              thunderbird = {
                enable = true;
                profiles = [ "personal" ];
              };
            };
          };
        };
      };
      programs = {
        thunderbird = {
          enable = true;
          package = pkgs.thunderbird-latest;
          profiles = {
            work = {
              isDefault = true;
              settings = commonSettings;
            };
            personal = {
              isDefault = false;
              settings = commonSettings;
            };
          };
          settings = {
            "privacy.donottrackheader.enabled" = true;
            "dom.event.clipboardevents.enabled" = false;
            "mail.chat.enabled" = false;
            "mail.shell.checkDefaultClient" = false;

            # Enable Global Search and Indexer in settings
            "mailnews.database.global.indexer.enabled" = true;
          };
        };
      };
    };
}

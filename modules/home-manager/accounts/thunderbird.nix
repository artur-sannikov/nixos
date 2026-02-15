{ pkgs, ... }:
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
        };
        personal = {
          isDefault = false;
        };
      };
      settings = {
        "privacy.donottrackheader.enabled" = true;
        "dom.event.clipboardevents.enabled" = false;
      };
    };
  };
}

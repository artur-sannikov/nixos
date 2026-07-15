{
  flake.modules.homeManager.gui = { config, pkgs, ... }: {
    programs = {
      firefox = {
        configPath = "${config.xdg.configHome}/mozilla/firefox";
        enable = true;
        profiles = {
          default-release = {
            isDefault = true;
            settings = {
              "extensions.autoDisableScopes" = 0; # Automatically enable extensions
            };
            extensions = {
              force = true; # Check if it removes logins?
              packages = with pkgs.nur.repos.rycee.firefox-addons; [
                bitwarden
                ublock-origin
              ];
              settings = {
                "uBlock0@raymondhill.net".settings = {
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
            };
            search = {
              force = true;
              default = "ddg";
              privateDefault = "ddg";
            };
          };
        };
      };
    };
    stylix = {
      targets = {
        firefox = {
          profileNames = [
            "default-release"
          ];
        };
      };
    };
  };
}

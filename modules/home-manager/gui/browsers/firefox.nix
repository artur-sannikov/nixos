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
              packages = with pkgs.nur.repos.rycee.firefox-addons; [
                bitwarden
                ublock-origin
              ];
              settings = {
                "uBlock0@raymondhill.net" =
                  let
                    customLists = [
                      "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/pro.txt"
                      "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Dandelion Sprout's Anti-Malware List.txt"
                      "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
                      "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/spam-tlds-ublock.txt"
                      "https://raw.githubusercontent.com/iam-py-test/my_filters_001/main/antimalware.txt"
                      "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt"
                      "https://raw.githubusercontent.com/yokoffing/filterlists/main/click2load.txt"
                      "https://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt"
                    ];
                  in
                  {
                    force = true;
                    settings = {
                      importedLists = customLists;
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
                      ]
                      ++ customLists;
                      uiTheme = "dark";
                      advancedUserEnabled = true;
                    };
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

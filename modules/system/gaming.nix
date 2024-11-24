{
  pkgs,
  username,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.gaming;
in
{
  options.gaming = {
    enable = lib.mkEnableOption "gaming";

    SteamUIScaling = mkOption {
      type = types.str;
      default = "1";
      description = "Steam UI scaling factor";
    };
  };
  config = mkIf cfg.enable {
    programs = {
      steam = {
        package = pkgs.steam.override {
          extraProfile = ''
            export STEAM_FORCE_DESKTOPUI_SCALING=${cfg.SteamUIScaling};
          '';
        };
        enable = true;
        gamescopeSession.enable = true;
      };
      gamemode = {
        enable = true;
      };
    };

    environment = {
      systemPackages = with pkgs; [
        heroic
        mangohud
        protonup
        lutris
      ];
      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${username}/.steam/root/compatibilitytools.d";
      };
    };
  };
}

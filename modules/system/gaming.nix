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
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable gaming mode";
    };
    fixDPI = mkOption {
      type = types.bool;
      default = false;
      description = "Fix UI scaling on HiDPI monitors";
    };
  };
  config = mkIf cfg.enable {
    programs = {
      steam = {
        package = pkgs.steam.override {
          extraProfile = ''
            export STEAM_FORCE_DESKTOPUI_SCALING=2;
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
        # Monitor temperature
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

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
        enable = true;
        package = pkgs.steam.override {
          extraLibraries = pkgs: [ pkgs.xorg.libxcb ];
          extraPkgs =
            pkgs: with pkgs; [
              gamescope-wsi
            ];
          extraProfile = ''
            export STEAM_FORCE_DESKTOPUI_SCALING=${cfg.SteamUIScaling};
          '';
        };
        # To enable HDR run Steam games with `gamemoderun gamescope --mangoapp --rt --force-grab-cursor --hdr-enabled -f -w 3840 -h 2160 --adaptive-sync --hdr-sdr-content-nits 250 --hdr-itm-target-nits 1000 -- %command%`
        gamescopeSession = {
          enable = true;
          env = {
            DXVK_HDR = "1";
            ENABLE_GAMESCOPE_WSI = "1";
          };
        };
      };
      gamescope = {
        enable = true;
        env = {
          DXVK_HDR = "1";
          ENABLE_GAMESCOPE_WSI = "1";
        };
      };
      gamemode = {
        enable = true;
      };
    };
    environment = {
      systemPackages = with pkgs; [
        mangohud
        protonup
        (lutris.override {
          extraPkgs = pkgs: [
            wineWowPackages.stable
            winetricks
          ];
        })
        (heroic.override {
          extraPkgs = pkgs: [
            gamescope
            gamemode
            gamescope-wsi
          ];
        })
      ];
      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${username}/.steam/root/compatibilitytools.d";
      };
    };
  };
}

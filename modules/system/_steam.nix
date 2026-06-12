{
  flake.modules.nixosModules.steam =
    {
      # cfg,
      pkgs,
      username,
      ...
    }:
    {
      programs = {
        steam = {
          enable = true;
          protontricks = {
            enable = true;
          };
          extraCompatPackages = with pkgs; [
            steamtinkerlaunch
          ];
          package = pkgs.steam.override {
            extraPkgs =
              pkgs': with pkgs'; [
                libXcursor
                libXi
                libXinerama
                libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib # Provides libstdc++.so.6
                libkrb5
                keyutils
              ];
            # extraProfile = ''
            #   export STEAM_FORCE_DESKTOPUI_SCALING=${cfg.SteamUIScaling};
            # '';
          };
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
        };
        gamemode = {
          enable = true;
        };
      };
      environment = {
        systemPackages = with pkgs; [
          mangohud
          protonup-ng
          protonup-qt
          protontricks
          umu-launcher
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

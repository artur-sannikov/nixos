{
  flake.modules.nixos.steam =
    {
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
            proton-ge-bin
          ];
          # gamescopeSession = {
          #   enable = true;
          #   env = {
          #     DXVK_HDR = "1";
          #     ENABLE_GAMESCOPE_WSI = "1";
          #   };
          # };
        };
        gamescope = {
          enable = true;
        };
        gamemode = {
          enable = true;
        };
      };
      environment = {
        sessionVariables = {
          STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${username}/.steam/root/compatibilitytools.d";
        };
      };
    };
}

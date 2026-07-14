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
          # From https://github.com/fufexan/nix-gaming
          platformOptimizations = {
            enable = true;
          };
          enable = true;
          protontricks = {
            enable = true;
          };
          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };
        gamescope = {
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

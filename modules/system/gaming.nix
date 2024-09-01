{ pkgs, username, ... }:
{
  programs = {
    steam = {
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
}

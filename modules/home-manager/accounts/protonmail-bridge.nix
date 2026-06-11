{ pkgs, ... }:
{
  flake.modules.homeModules.personal-email = {
    services = {
      protonmail-bridge = {
        enable = true;
        logLevel = "warn";
      };
    };
    home = {
      packages = with pkgs; [ protonmail-bridge ];
    };
  };
}

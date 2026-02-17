{
  pkgs,
  flake-inputs,
  lib,
  ...
}:
{
  programs.firefox = {
    enable = true;
    profiles = {
      default-release = {
        isDefault = true;
        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";
        };
      };
      tidal-hifi = {
        isDefault = false;
        id = 1;
        bookmarks = {
          force = true;
          settings = [
            {
              name = "tidal";
              url = "https://listen.tidal.com/";
            }
          ];
        };
        # extensions.packages = with flake-inputs.firefox-extensions.packages.${pkgs.system}; [
        #   bitwarden
        #   ublock-origin
        #   vimium
        # ];
        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";
        };
      };
    };
    # };
  };
  stylix.targets.firefox.profileNames = [
    "default-release"
  ];
}

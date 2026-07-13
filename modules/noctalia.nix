{ inputs, ... }:
{
  flake.modules.homeManager.noctalia = {
    imports = [
      inputs.noctalia.homeModules.default
    ];
    programs = {
      noctalia = {
        enable = true;
        settings = {
          # For Niri overview blurred wallpaper
          backdrop = {
            enabled = true;
          };
          bar = {
            main = {
              enabled = true;
              position = "top";
              background_opacity = 0.85;
            };
          };

          dock = {
            enabled = false;
          };
        };
      };
    };
  };
}

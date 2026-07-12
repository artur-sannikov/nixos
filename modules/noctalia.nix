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
          bar = {
            main = {
              enabled = true;
              position = "top";
            };
          };

          dock = {
            enabled = true;
            position = "bottom";
            auto_hide = true;
          };
        };
      };
    };
  };
}

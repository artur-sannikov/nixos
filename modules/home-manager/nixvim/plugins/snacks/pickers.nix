{
  flake.modules.nixvim.default = { lib, ... }: {
    plugins.snacks = {
      settings.picker = {
        layout = "telescope";
        layouts.telescope = {
          reverse = false;
          # Way to make it nix-native?
          layout = lib.generators.mkLuaInline ''
              {
                box = "vertical",
                backdrop = false,
                width = 0.4,
                height = 0.8,
                border = "none",
              {
                win = "preview",
                title = "{preview:Preview}",
                height = 0.45,
                border = true,
                title_pos = "center",
              },
              {
                win = "input",
                height = 1,
                border = true,
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
              {
                win = "list",
                title = " Results ",
                height = 0.45,
                title_pos = "center",
                border = true,
              },
            }
          '';
        };
      };
    };
  };
}

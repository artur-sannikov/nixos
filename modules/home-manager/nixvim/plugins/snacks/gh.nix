{
  flake.modules.nixvim.default = {
    plugins = {
      snacks = {
        settings = {
          gh = {
            enabled = true;
            wo = {
              number = true;
              relativenumber = true;
              wrap = true;
            };

          };
        };
      };
    };
  };
}

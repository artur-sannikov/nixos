{
  programs = {
    nixvim = {
      plugins = {
        oil = {
          enable = true;
          settings = {
            deleteToTrash = true;
            float = {
              padding = 2;
              maxWidth = 0;
              maxHeight = 0;
              border = "rounded";
              winOptions = {
                winblend = 0;
              };
            };
          };
        };
      };
      keymaps = [
        {
          key = "<leader>o";
          mode = "n";
          action = ":Oil --float <CR>";
        }
      ];
    };
  };
}

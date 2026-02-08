{
  programs = {
    nixvim = {
      plugins = {
        neogit = {
          enable = true;
          settings = {
            disable_line_numbers = false;
            disable_relative_line_numbers = false;
          };
        };
      };
      keymaps = [
        {
          action = "<cmd>Neogit<CR>";
          key = "<leader>ng";
          mode = "n";
          options = {
            silent = true;
            desc = "Show Neogit UI";
          };
        }
        {
          action = "<cmd>Neogit commit<CR>";
          key = "<leader>gc";
          mode = "n";
          options = {
            silent = true;
            desc = "Neogit commit";
          };
        }
      ];
    };
  };
}

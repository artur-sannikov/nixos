{
  programs = {
    nixvim = {
      plugins = {
        neogit = {
          enable = true;
        };
      };
      keymaps = [
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

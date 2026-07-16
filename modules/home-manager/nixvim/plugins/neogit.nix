{
  flake.modules.nixvim.default = {
    plugins = {
      neogit = {
        enable = true;
        settings = {
          disable_line_numbers = false;
          disable_relative_line_numbers = false;

          disable_hint = true;

          integrations = {
            diffview = true;
            snacks = true;
          };
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
    ];
  };
}

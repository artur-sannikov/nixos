{
  programs = {
    nixvim = {
      plugins = {
        octo = {
          enable = true;
        };
      };
      keymaps = [
        {
          mode = "n";
          key = "<leader>oi";
          action = "<cmd>Octo issue list<cr>";
          options = {
            silent = true;
            desc = "List GitHub Issues";
          };
        }
      ];
    };
  };
}

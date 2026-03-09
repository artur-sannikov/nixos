{
  plugins = {
    gitsigns = {
      enable = true;
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "[c";
      action = "<cmd>Gitsigns next_hunk<cr>";
      options = {
        silent = true;
        desc = "Next Git Hunk";
      };
    }
    {
      mode = "n";
      key = "]c";
      action = "<cmd>Gitsigns prev_hunk<cr>";
      options = {
        silent = true;
        desc = "Previous Git Hunk";
      };
    }
    {
      mode = "n";
      key = "<leader>hd";
      action = "<cmd>Gitsigns diffthis<cr>";
      options = {
        silent = true;
        desc = "Show hunk diffs";
      };
    }
  ];
}

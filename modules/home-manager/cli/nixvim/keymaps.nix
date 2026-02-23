{
  programs.nixvim = {
    keymaps = [
      {
        # Move line down
        mode = "n";
        key = "<C-j>";
        action = ":move .+1<CR>==";
      }
      {
        # Move line up
        mode = "n";
        key = "<C-k>";
        action = ">:move .-2<CR>==";
      }
      {
        # Move selected lines down
        mode = "v";
        key = "<C-j>";
        action = ":move '>+1<CR>gv=gv";
      }
      {
        # Move selected lines up
        mode = "v";
        key = "<C-k>";
        action = ":move '<-2<CR>gv=gv";
      }

      # Rename all instances of X with LSP
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
      }
      {
        mode = "t";
        key = "<Esc>";
        action = "<C-\\><C-n>";
        options = {
          desc = "Switch to normal mode";
        };
      }
      {
        mode = "n";
        key = "<leader>lq";
        action = "ciw\"\"<Esc>P";
        options = {
          desc = "Surround word with quotes";
        };
      }
      {
        mode = "n";
        key = "<leader>st";
        action.__raw = ''
          function()
            vim.cmd.vnew()
            vim.cmd.term()
            vim.cmd.wincmd("J")
            vim.api.nvim_win_set_height(0, 5)
          end
        '';
        options = {
          silent = true;
          desc = "Open small terminal";
        };
      }
    ];
  };
}

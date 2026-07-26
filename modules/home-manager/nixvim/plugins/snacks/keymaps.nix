{
  flake.modules.nixvim.default = {
    keymaps = [
      {
        key = "<leader>fd";
        mode = [ "n" ];
        action = "<cmd>:lua Snacks.picker.files()<CR>";
        options = {
          desc = "Search files by name";
        };
      }
      {
        mode = "n";
        key = "<leader>,";
        action = "<cmd>:lua Snacks.picker.buffers()<CR>";
        options = {
          desc = "Search buffers";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gc";
        action = "<cmd>Telescope git_commits<cr>";
        options = {
          silent = true;
          desc = "Telescope search commits";
        };
      }
      {
        key = "<leader>gl";
        mode = "n";
        action.__raw = ''
          function()
            Snacks.picker.git_log({
              finder = "git_log",
              format = "git_log",
              preview = "git_show",
              confirm = "git_checkout",
              layout = "vertical",
            })
          end
        '';
        options.desc = "Git log";
      }
      {
        key = "<leader>fg";
        mode = [ "n" ];
        action = "<cmd>:lua Snacks.picker.grep()<CR>";
        options = {
          desc = "Search in files in cwd";
        };
      }

      # GitHub interactions (alternative octo.nvim)
      {
        key = "<leader>gi";
        mode = [ "n" ];
        action = "<cmd>:lua Snacks.picker.gh_issue()<CR>";
        options = {
          desc = "GitHub Issues (open)";
        };
      }
      {
        key = "<leader>gI";
        mode = [ "n" ];
        action = "<cmd>:lua Snacks.picker.gh_issue({ state = 'all' })<CR>";
        options = {
          desc = "GitHub Issues (all)";
        };
      }
      {
        key = "<leader>gp";
        mode = [ "n" ];
        action = "<cmd>lua Snacks.picker.gh_pr()<CR>";
        options = {
          desc = "GitHub Pull Requests (open)";
        };
      }
      {
        key = "<leader>gP";
        mode = [ "n" ];
        action = "<cmd>lua Snacks.picker.gh_pr({ state = 'all' })<CR>";
        options = {
          desc = "GitHub Pull Requests (all)";
        };
      }

      # Buffers
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>:lua Snacks.bufdelete.delete()<CR>";
        options = {
          silent = true;
          desc = "Buffer delete";
        };
      }
      {
        mode = "n";
        key = "<leader>ba";
        action = "<cmd>lua Snacks.bufdelete.all()<CR>";
        options = {
          silent = true;
          desc = "Buffer delete all";
        };
      }
      {
        mode = "n";
        key = "<leader>bo";
        action = "<cmd>:lua Snacks.bufdelete.other()<CR>";
        options = {
          silent = true;
          desc = "Buffer delete other";
        };
      }
    ];
  };
}

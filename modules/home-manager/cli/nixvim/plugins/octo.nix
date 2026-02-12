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
        {
          mode = "n";
          key = "<leader>op";
          action = "<cmd>Octo pr list<cr>";
          options = {
            silent = true;
            desc = "List GitHub PRs";
          };
        }
        {
          mode = "n";
          key = "<leader>on";
          action = "<cmd>Octo notification list<cr>";
          options = {
            silent = true;
            desc = "List GitHub Notifications";
          };
        }
        {
          mode = "n";
          key = "<leader>od";
          action = "<cmd>Octo discussion list<cr>";
          options = {
            silent = true;
            desc = "List GitHub Discussions";
          };
        }
        {
          mode = "n";
          key = "<leader>os";
          action.__raw = ''
            function()
              require("octo.utils").create_base_search_command { include_current_repo = true }
            end
          '';
          options = {
            silent = true;
            desc = "Search GitHub";
          };
        }
      ];
    };
  };
}

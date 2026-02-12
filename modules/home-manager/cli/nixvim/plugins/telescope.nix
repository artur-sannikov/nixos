let
  picker_theme = "dropdown";
in
{
  programs.nixvim = {
    plugins = {
      telescope = {
        enable = true;
        extensions = {
          # https://github.com/nvim-telescope/telescope-fzf-native.nvim
          fzf-native.enable = true;
        };
        settings = {
          layout_strategy = "horizontal";
          layout_config = {
            width = 0.9;
            mirror = true;
            prompt_position = "top";
          };
          pickers = {
            find_files = {
              theme = "${picker_theme}";
            };
            buffers = {
              theme = "${picker_theme}";
            };
            git_commits = {
              theme = "${picker_theme}";
            };
          };
          mappings = {
            i = {
              "<C-n>" = "move_selection_next";
              "<C-p>" = "move_selection_previous";
              "<C-c>" = "close";
            };
          };
        };
      };
    };
    keymaps = [
      {
        key = "<leader>fd";
        mode = [ "n" ];
        action = "<cmd>Telescope find_files<cr>";
        options = {
          desc = "Search files by name";
        };
      }
      {
        mode = "n";
        key = "<leader>b";
        action = "<cmd>Telescope buffers<cr>";
        options = {
          silent = true;
          desc = "Telescope list buffers";
        };
      }
    ];
  };
}

{
  imports = [
    ./autocmd.nix
    ./plugins/default.nix
    ./keymaps.nix
  ];
  programs.nixvim = {
    # Fix for neogit crash: https://github.com/NeogitOrg/neogit/issues/1896
    # extraConfigLua = builtins.readFile ./fix_neogit.lua;
    extraConfigLua = ''
      local M = {}

      function M:open()
        if self.buffer then
          return self
        end

        local status_maps = config.get_reversed_status_maps()

        local existing = vim.fn.bufnr("NeogitConsole")
        if existing ~= -1 then
          local buftype = vim.api.nvim_get_option_value("buftype", { buf = existing })
          if buftype == "terminal" then
            vim.api.nvim_buf_delete(existing, { force = true })
          end
        end

        self.buffer = Buffer.create {
          name = "NeogitConsole",
        }
      end
    '';
    enable = true;
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    opts = {
      termguicolors = true;
      shiftwidth = 4;
      expandtab = true;
      colorcolumn = "80";
      clipboard = "unnamedplus";
      number = true;
      relativenumber = true;
      cursorline = true;
      spell = true;
      spelllang = "en_us";
      shell = "zsh";
      # Remove global status line to make split windows visibly separate
      laststatus = 3;
    };
    diagnostic = {
      settings = {
        virtual_lines = {
          current_line = true;
        };
      };
    };
    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          default_integrations = true;
          flavour = "mocha";

          # https://github.com/catppuccin/nvim/tree/main/lua/catppuccin/groups/integrations
          integrations = {
            blink-cmp = true;
            coc-nvim = true;
            fzf = true;
            markview = true;
            neogit = true;
            treesitter_context = true;
            telescope = true;
          };
          # Default color is barely visible for split windows
          custom_highlights = ''
            function(colors)
              return {
                WinSeparator = { fg = colors.flamingo },
              }
            end
          '';
          term_colors = true;
          transparent_background = true;
        };
      };
    };
    extraConfigVim = ''
      syntax off "" Disable syntax highlighting, treesitter handles it
      set nowrap
    '';
  };
}

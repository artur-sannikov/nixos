{
  imports = [
    ./autocmd.nix
    ./plugins/default.nix
    ./keymaps.nix
  ];
  programs.nixvim = {
    enable = true;
    globals = {
      mapleader = " ";
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

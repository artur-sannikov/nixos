{
  imports = [
    ./autocmd.nix
    ./plugins
    ./keymaps.nix
  ];
  programs.nixvim = {
    enable = true;
    opts = {
      termguicolors = true;
      shiftwidth = 4;
      expandtab = true;
      colorcolumn = "80";
      clipboard = "unnamedplus";
      number = true;
      relativenumber = true;
      spell = true;
      spelllang = "en_us";
      # formatoptions = "aw";
    };
    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          default_integrations = true;
          flavour = "mocha";

          # https://github.com/catppuccin/nvim/tree/main/lua/catppuccin/groups/integrations
          integrations = {
            cmp = true;
            treesitter = true;
            telescope = true;
          };

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

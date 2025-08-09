{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      # https://github.com/nvim-telescope/telescope-fzf-native.nvim
      fzf-native.enable = true;
    };
    settings = {
      pickers = {
        find_files = {
          theme = "ivy";
        };
      };
    };
    keymaps = {
      "<space>fd" = {
        mode = "n";
        action = "find_files";
        options = {
          desc = "Find files in current directory";
        };
      };
    };
  };
}

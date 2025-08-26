{
  imports = [
    ./plugins
  ];
  programs.nixvim = {
    enable = true;
    opts = {
      termguicolors = true;
      shiftwidth = 4;
      clipboard = "unnamedplus";
      number = true;
      relativenumber = true;
      spell = true;
      spelllang = "en_us";
      formatoptions = "aw";
    };
    extraConfigVim = ''
      syntax off "" Distable syntax highlighting, treesitter handles it
    '';
  };
}

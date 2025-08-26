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
    };
    extraConfigVim = ''
      syntax off "" Distable syntax highlighting, treesitter handles it
    '';
  };
}

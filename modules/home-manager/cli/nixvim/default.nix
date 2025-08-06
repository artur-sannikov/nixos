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
    };
    extraConfigVim = ''
      syntax off "" Distable syntax highlighting, treesitter handles it
    '';
  };
}

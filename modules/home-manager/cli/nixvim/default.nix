{
  imports = [
    ./plugins
  ];
  programs.nixvim = {
    enable = true;
    opts = {
      termguicolors = true;
    };
    extraConfigVim = ''
      syntax off "" Distable syntax highlighting, treesitter handles it
    '';
  };
}

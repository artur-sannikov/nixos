{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;
    plugins = {
      lualine.enable = true;
      lsp-format = {
        enable = true;
      };
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          lua_ls.enable = true;
          r_language_server = {
            enable = true;
            package = pkgs.rPackages.languageserver;
          };
          bashls.enable = true;
        };
      };
    };
  };
}
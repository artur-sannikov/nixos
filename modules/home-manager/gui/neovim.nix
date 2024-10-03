{ pkgs, ... }:
{
  programs = {
    nixvim = {
      enable = true;
      plugins = {
        direnv = {
          enable = true;
        };
        lsp = {
          enable = true;
          servers = {
            r-language-server = {
              enable = true;
            };
          };
        };
      };
    };
  };
}

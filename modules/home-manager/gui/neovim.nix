{ pkgs, ... }:
{
  programs = {
    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        fzf-vim
        direnv-vim
      ];
    };
  };
}

{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "yarepl.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "milanglacier";
          repo = "yarepl.nvim";
          rev = "v0.11.0";
          hash = "sha256-6kl7xQpDiyuiqmjTPVbAjff+EGIVzWw/RBOaqZP3iGo=";
        };
        nvimSkipModules = [ "yarepl.extensions.fzf" ];
      })
    ];
    extraConfigLua = builtins.readFile ./yarepl.lua;
    keymaps = [
      {
        mode = "n";
        key = "<leader>rs";
        action = "<Plug>(REPLStart)";
      }
      {
        mode = "n";
        key = "<leader>rc";
        action = "<Plug>(REPLClose)";
      }
      {
        mode = "n";
        key = "<leader>sl";
        action = "<Plug>(REPLSendLine)";
      }
      {
        mode = "v";
        key = "<leader>sv";
        action = "<Plug>(REPLSendVisual)";
      }
    ];
  };
}

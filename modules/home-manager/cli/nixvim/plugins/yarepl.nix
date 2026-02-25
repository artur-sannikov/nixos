{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "yarepl.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "milanglacier";
          repo = "yarepl.nvim";
          rev = "v0.12.0";
          hash = "sha256-3JkrQCTvWFE6CRRbeiqqmA8tVVl4ZzE+hQX75ODuHo8=";
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
        key = "<leader>rr";
        action = "<Plug>(REPLSendLine)j";
      }
      {
        mode = "v";
        key = "<leader>rr";
        action = "<Plug>(REPLSendVisual)";
      }
      {
        mode = "n";
        key = "<leader>rf";
        action = "<Plug>(REPLFocus)";
      }
    ];
  };
}

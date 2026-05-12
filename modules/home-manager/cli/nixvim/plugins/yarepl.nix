{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "yarepl.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "milanglacier";
        repo = "yarepl.nvim";
        rev = "v0.14.0";
        hash = "sha256-cqZUCUlo8hwuOpjflYMvw1DJNnOXhhK1e3LrrzgKgkc=";
      };
      nvimSkipModules = [ "yarepl.extensions.fzf" ];
    })
  ];
  extraConfigLua = builtins.readFile ./yarepl.lua;
  keymaps = [
    {
      mode = "n";
      key = "<leader>rs";
      action = "<Plug>(yarepl-start)";
    }
    {
      mode = "n";
      key = "<leader>rc";
      action = "<Plug>(yarepl-close)";
    }
    {
      mode = "n";
      key = "<leader>rr";
      action = "<Plug>(yarepl-send-line)j";
    }
    {
      mode = "v";
      key = "<leader>rr";
      action = "<Plug>(yarepl-source-visual)";
    }
    {
      mode = "n";
      key = "<leader>rf";
      action = "<Plug>(yarepl-focus)";
    }
  ];
}

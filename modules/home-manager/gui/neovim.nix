# { pkgs, fromGitHub, ... }:
# {

# let
#   fromGitHub = rev: ref: repo: pkgs.vimUtils.buildVimPlugin {
#     pname = "${lib.strings.sanitizeDerivationName repo}";
#     version = ref;
#     src = builtins.fetchGit {
#       url = "https://github.com/${repo}.git";
#       ref = ref;
#       rev = rev;
#     };
#   };
#   in
#   programs = {
#     neovim = {
#       enable = true;
#       extraPlugins = with pkgs.vimPlugins; [
#         fzf-lua
#         (fromGitHub "253e52fe26f2816acae68e7e0ced9d89adf3f85a" "main" "gennaro-tedesco/nvim-possession")
#         (fromGitHub "b10ec78df938a1e06217f965b32fb1b960681cff" "master"
#           "nvim-telescope/telescope-bibtex.nvim"
#         )
#       ];
#     };
#   };
# }

{ pkgs, lib, ... }:

let
  fromGitHub =
    rev: ref: repo:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
        rev = rev;
      };
    };
in
{
  extraPlugins = with pkgs.vimPlugins; [
    fzf-lua
    (fromGitHub "253e52fe26f2816acae68e7e0ced9d89adf3f85a" "main" "gennaro-tedesco/nvim-possession")
    (fromGitHub "b10ec78df938a1e06217f965b32fb1b960681cff" "master"
      "nvim-telescope/telescope-bibtex.nvim"
    )
  ];
  extraConfigLua = ''
    require("nvim-possession").setup {
      autoswitch = {
        enable = true,
      },
    }
    vim.opt.title = true
    vim.opt.titlestring = [[%{luaeval('vim.g[require("nvim-possession.config").sessions.sessions_variable] or ""')}]]
      .. [[ - %f %h%m%r%w ]]

    require"telescope".load_extension("bibtex")
  '';

  keymaps = [
    {
      key = "<leader>ss";
      mode = "n";
      action = ":lua require('nvim-possession').list()<CR>";
      options = {
        desc = "[s]ession: [s]elect";
      };
    }
    {
      key = "<leader>sn";
      mode = "n";
      action = ":lua require('nvim-possession').new()<CR>";
      options = {
        desc = "[s]ession: [n]ew";
      };
    }
    {
      key = "<leader>su";
      mode = "n";
      action = ":lua require('nvim-possession').update()<CR>";
      options = {
        desc = "[s]ession: [u]pdate";
      };
    }
    {
      key = "<leader>sd";
      mode = "n";
      action = ":lua require('nvim-possession').delete()<CR>";
      options = {
        desc = "[s]ession: [d]elete";
      };
    }
  ];
}

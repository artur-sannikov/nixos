{ pkgs, ... }:
{
  programs.nixvim = {
    filetype = {
      pattern = {
        # # javascript template files look better with javascript
        # parser
        ".*\.js\.j2" = "js";
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      ansible-vim
      coc-nvim
      (pkgs.vimUtils.buildVimPlugin {
        pname = "coc-ansible";
        version = "2024-05-17";
        src = pkgs.fetchFromGitHub {
          owner = "yaegassy";
          repo = "coc-ansible";
          rev = "33bee0daed278cf9f148017c6ffb03aefaaae085";
          sha256 = "sha256-tF0O9lhY0eML/RT7hN39NaV6dSq+vlfc9DSbPaJlR0s=";
        };
      })
    ];
    globals = {
      coc_filetype_map = {
        "yaml.ansible" = "ansible";
      };
    };
    plugins = {
      lualine.enable = true;
      lsp-format = {
        enable = true;
      };
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          # lua
          lua_ls.enable = true;

          # R
          r_language_server = {
            enable = true;
            package = null;
          };
          air = {
            enable = true;
          };

          # bash
          bashls.enable = true;

          # Python
          pylsp = {
            enable = true;
          };

          # nix
          nixd = {
            enable = true;
          };

          # toml
          taplo = {
            enable = true;
          };

          # typst
          tinymist = {
            enable = true;
            settings = {
              exportPdf = "onSave";
              formatterMode = "typstyle";
            };
          };

          # OpenTofu
          tofu_ls = {
            enable = true;
          };

          # yaml
          yamlls = {
            enable = true;
          };
        };
      };
    };
  };
}

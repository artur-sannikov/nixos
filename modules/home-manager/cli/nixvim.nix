{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
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
          pylsp = {
            enable = true;
          };
        };
      };
      quarto.enable = true;
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lspFallback = true;
            timeoutMs = 500;
          };
          formatters_by_ft = {
            python = [
              "black"
              "isort"
            ];
            nix = [ "nixfmt" ];
            yaml = [ "yamlfmt" ];
          };
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "path"; }
            { name = "nvim_lsp"; }
          ];
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-cmdline.enable = true;
      direnv.enable = true;
      nix.enable = true;
      web-devicons = {
        enable = true;
      };
      bufferline = {
        enable = true;
        settings = {
          highlights = {
            buffer_selected = {
              bg = "#356b37";
            };
            tab_selected = {
              bg = "#356b37";
            };
            numbers_selected = {
              bg = "#356b37";
            };
          };
        };
      };
      neo-tree = {
        enable = true;
        enableDiagnostics = true;
        enableGitStatus = true;
      };
      smartcolumn = {
        enable = true;

        settings = {
          colorcolumn = "80";
          scope = "file";
        };
      };
    };
    autoCmd = [
      {
        command = "setfiletype json";
        event = [
          "BufEnter"
          "BufWinEnter"
        ];
        pattern = [
          "*.hujson"
        ];
      }
    ];
    keymaps = [
      {
        mode = "n";
        key = "<leader>date";
        action = '':r ! echo "date: $(date --iso)"<CR>'';
        options = {
          remap = true;
        };
      }
    ];
    opts = {
      number = true;
      shiftwidth = 4;
      breakindent = true;
      expandtab = true;
      colorcolumn = "80";
      # guifont = "Iosevka :h14";
      # termguicolors = true;
    };
    highlight = {
      ColorColumn = {
        bg = "#2e2e2e";
      };
    };
  };
}

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
            package = null;
          };
          bashls.enable = true;
          pylsp = {
            enable = true;
          };
          ansiblels = {
            enable = true;
          };
        };
      };
      quarto.enable = true;

      # Formatters
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

      lint = {
        enable = true;
        lintersByFt = {
          ansible = [
            "ansible_lint"
            "yaml"
          ];
          yaml = [ "yamllint" ];
        };
      };

      # Completion
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "git"; }
            { name = "nvim_lsp"; }
            { name = "emoji"; }
            { name = "buffer"; }
            {
              name = "luasnip";
              keywordLength = 3;
            }
          ];
          snippet = {
            expand = "luasnip";
          };
          mapping = {
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<Tab>" = "cmp.mapping.confirm({ select = true })";
          };
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-cmdline.enable = true;

      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };
      };

      direnv.enable = true;
      nix.enable = true;
      web-devicons = {
        enable = true;
      };
      bufferline = {
        enable = true;
        settings = {
          options = {
            offsets = [
              {
                filetype = "neo-tree";
                text = "Files";
                highlight = "Directory";
                text_align = "left";
              }
            ];
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

    # Extra plugins
    extraPlugins = with pkgs.vimPlugins; [
      no-neck-pain-nvim
    ];

    # Extra configuration

    extraConfigLua = builtins.readFile ./no-neck-pain.lua;
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

      {
        mode = "n";
        key = "]b";
        action = "<cmd>BufferLineCycleNext<cr>";
        options = {
          desc = "Cycle to next buffer";
        };
      }

      {
        mode = "n";
        key = "[b";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options = {
          desc = "Cycle to previous buffer";
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

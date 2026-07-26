{
  flake.modules.nixvim.default =
    { config, ... }:
    {
      globals = {
        # Disable entire built-in ftplugin mappings to avoid conflicts.
        # See https://github.com/neovim/neovim/tree/master/runtime/ftplugin
        # for built-in ftplugins.
        no_plugin_maps = true;
      };
      plugins = {
        treesitter = {
          enable = true;
          grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
            bash
            bibtex
            caddy
            comment
            css
            csv
            desktop
            dockerfile
            gitcommit
            git_config
            gitignore
            git_rebase
            hcl
            helm
            hjson
            html
            ini
            javascript
            jinja
            jinja_inline
            jq
            json
            just
            latex
            lua
            make
            markdown
            markdown_inline
            mermaid
            nix
            passwd
            python
            qmljs
            query
            r
            readline
            regex
            requirements # pip requirements
            scss
            sql
            ssh_config
            styled
            terraform
            toml
            tsv
            typst
            vim
            xml
            yaml
          ];
          settings = {
            highlight = {
              enable = true;
            };
            indent = {
              enable = true;
            };
          };
        };
        # https://github.com/jmbuhr/nvim-config/blob/cfe8f0b61dcd3565c6dbb0e0ec3c1908d35ddc70/lua/plugins/treesitter.lua
        treesitter-textobjects = {
          enable = true;
          settings = {
            select = {
              lookahead = true;
            };
          };
        };
      };
      keymaps = [
        {
          mode = [
            "x"
            "o"
          ];
          key = "io";
          action.__raw = ''
            function()
              require("nvim-treesitter-textobjects.select")
                .select_textobject("@codechunk.inner", "textobjects")
            end
          '';
          options.desc = "Inside code cell";
        }
        {
          mode = [
            "x"
            "o"
          ];
          key = "ao";
          action.__raw = ''
            function()
              require("nvim-treesitter-textobjects.select")
                .select_textobject("@codechunk.outer", "textobjects")
            end
          '';
          options.desc = "Around code chunk";
        }

        # NOTE: still not convinced about their use
        # I'm faster with jump lists and line numbers
        # {
        #   mode = [
        #     "n"
        #     "x"
        #     "o"
        #   ];
        #   key = "]q";
        #   action.__raw = ''
        #     function()
        #       require("nvim-treesitter-textobjects.move")
        #         .goto_next_start("@codechunk.outer", "textobjects")
        #     end
        #   '';
        #   options.desc = "Next code chunk";
        # }
        # {
        #   mode = [
        #     "n"
        #     "x"
        #     "o"
        #   ];
        #   key = "[q";
        #   action.__raw = ''
        #     function()
        #       require("nvim-treesitter-textobjects.move")
        #         .goto_previous_start("@codechunk.outer", "textobjects")
        #     end
        #   '';
        #   options.desc = "Previous code chunk";
        # }
      ];
    };
}

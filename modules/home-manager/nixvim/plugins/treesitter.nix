{
  flake.modules.nixvim.default =
    { config, ... }:
    {
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
            markdown_inline
            nix
            passwd
            python
            qmljs
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
      };
    };
}

{ pkgs, ... }:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      bibtex
      caddy
      comment
      css
      csv
      desktop
      dockerfile
      git_config
      git_rebase
      gitcommit
      gitignore
      hcl
      helm
      hjson
      html
      ini
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
}

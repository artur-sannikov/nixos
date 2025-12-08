{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        # If auto-format is disable do not run formatting on save
        format_on_save = ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end
            return { timeout_ms = 4500, lsp_fallback = true }, on_format
           end
        '';
        formatters_by_ft = {
          json = [ "prettier" ];
          python = [
            "black"
            "isort"
          ];
          css = [ "prettier" ];
          html = [ "prettier" ];
          jinja = [ "djlint" ];
          javascript = [ "prettier" ];
          quarto = [ "injected" ];
          markdown = [ "prettier" ];
          nix = [ "nixfmt" ];
          r = [ "air" ];
          sh = [ "shfmt" ];
          scss = [ "prettier" ];
          lua = [ "stylua" ];
          yaml = [ "prettier" ];
          "yaml.ansible" = [ "ansible-lint" ];
        };
        formatters.ansible-lint.append_args = [
          "--fix"
          "all"
        ];
      };
    };
    keymaps = [
      {
        # https://github.com/stevearc/conform.nvim/issues/192
        # Cheers ram-xv!
        mode = "n";
        key = "<leader>tf";
        action.__raw = ''
          function()
            if vim.b.disable_autoformat then
              vim.b.disable_autoformat = false
              vim.notify("Enabled autoformat for this buffer")
            else
              vim.b.disable_autoformat = true
              vim.notify("Disabled autoformat for this buffer")
            end
          end
        '';
      }
    ];
  };
}

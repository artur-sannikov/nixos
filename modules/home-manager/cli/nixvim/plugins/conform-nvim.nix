{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 500;
        };
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
          typst = [ "typstyle" ];
          yaml = [ "prettier" ];
          # Disable formatter for Ansible
          "yaml.ansible" = [ ];
        };
      };
    };
    # userCommands = {
    #   "FormatDisable" = {
    #     command.__raw = ''
    #       function(args)
    #         if args.bang then
    #         -- If autoformat is currently disabled for this buffer,
    #         -- then enable it, otherwise disable it
    #         if vim.b.disable_autoformat then
    #           vim.cmd 'FormatEnable'
    #           vim.notify 'Enabled autoformat for current buffer'
    #         else
    #           vim.cmd 'FormatDisable!'
    #           vim.notify 'Disabled autoformat for current buffer'
    #         end
    #       end,
    #     '';
    #     bang = true;
    #     desc = "Disable autoformat-on-save";
    #   };
    # };
    # keymaps = [
    #   {
    #     mode = "n";
    #     key = "<leader>tf";
    #     action.__raw = ''
    #       function()
    #         if vim.b.disable_autoformat then
    #           vim.b.disable_autoformat = false
    #           vim.notify("Enabled autoformat for this buffer")
    #         else
    #           vim.b.disable_autoformat = true
    #           vim.notify("Disabled autoformat for this buffer")
    #         end
    #       end,
    #     '';
    #   }
    # ];
  };
}

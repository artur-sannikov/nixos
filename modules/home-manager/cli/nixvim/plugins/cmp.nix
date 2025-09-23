{
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          { name = "luasnip"; }
        ];
        # mapping = {
        #   "<C-n>" = "cmp.mapping.select_next_item()";
        #   "<C-p>" = "cmp.mapping.select_prev_item()";
        #   "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        #   "<C-f>" = "cmp.mapping.scroll_docs(4)";
        #   "<C-Space>" = "cmp.mapping.complete()";
        #   "<C-e>" = "cmp.mapping.close()";
        #   "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
        # };
      };
    };
    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-cmdline.enable = true;
  };
}

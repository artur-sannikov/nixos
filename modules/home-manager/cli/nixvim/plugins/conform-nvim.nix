{
  programs.nixvim.plugins.conform-nvim = {
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
        markdown = [ "prettier" ];
        nix = [ "nixfmt" ];
        r = [ "air" ];
        sh = [ "shfmt" ];
        scss = [ "prettier" ];
        typst = [ "typstyle" ];
        yaml = [ "prettier" ];
        # "yaml.ansible" = [ "ansible-lint" ];
      };
    };
  };
}

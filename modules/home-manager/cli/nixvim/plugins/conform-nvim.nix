{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        lspFallback = true;
        timeoutMs = 500;
      };
      formatters_by_ft = {
        json = [ "prettier" ];
        python = [
          "black"
          "isort"
        ];
        nix = [ "nixfmt" ];
        markdown = [ "prettier" ];
        sh = [ "shfmt" ];
        typst = [ "typstyle" ];
        r = [ "air" ];
        yaml = [ "prettier" ];
      };
    };
  };
}

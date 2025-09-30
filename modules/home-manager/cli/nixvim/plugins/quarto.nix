{
  programs.nixvim.plugins = {
    quarto = {
      enable = true;
      settings = {
        lspFeatures = {
          enabled = true;
          languages = [
            "r"
            "python"
          ];
          chunks = "curly";
        };
        codeRunner = {
          enabled = true;
          default_method = "molten";
          diagnostics = {
            enabled = true;
            triggers = [ "BufWritePost" ];
          };
        };
      };
    };
    otter = {
      enable = true;
    };
  };
}

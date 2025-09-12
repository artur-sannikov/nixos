{
  programs.nixvim.plugins = {
    quarto = {
      enable = true;
      settings = {
        lspFeatures = {
          enabled = true;
          chunks = "curly";
        };
        codeRunner = {
          enabled = true;
          default_method = "molten";
        };
      };
    };
    otter = {
      enable = true;
    };
  };
}

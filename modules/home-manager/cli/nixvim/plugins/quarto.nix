{
  plugins = {
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
        };
      };
    };
    otter = {
      enable = true;
    };
  };
}

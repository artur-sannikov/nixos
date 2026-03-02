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
          enabled = false;
        };
      };
    };
    otter = {
      enable = true;
    };
  };
}

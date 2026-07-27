{
  flake.modules.nixvim.default = {
    plugins = {
      quarto = {
        enable = true;
        settings = {
          lspFeatures = {
            enabled = true;
            languages = [
              "r"
              "python"
              "html"
            ];
            chunks = "curly";
          };
          codeRunner = {
            # Use iron.nvim
            enabled = false;
          };
        };
      };
      otter = {
        enable = true;
      };
    };
  };
}

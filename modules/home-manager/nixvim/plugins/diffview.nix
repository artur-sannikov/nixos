{
  flake.modules.nixvim.default = {
    plugins = {
      diffview = {
        enable = true;
      };
    };
  };
}

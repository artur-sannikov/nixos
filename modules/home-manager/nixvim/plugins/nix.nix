{
  flake.modules.nixvim.default = {
    plugins = {
      nix = {
        enable = true;
      };
    };
  };
}

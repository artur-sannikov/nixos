{
  flake.modules.nixvim.default = {
    plugins = {
      luasnip = {
        enable = true;
        fromLua = [ { paths = ./lua-snippets; } ];
        settings = {
          enable_autosnippets = true;
        };
      };
    };
  };
}

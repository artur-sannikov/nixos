{
  flake.modules.nixvim.default = {
    plugins = {
      autoclose = {
        enable = true;
        settings = {
          keys = {
            "'" = {
              escape = false;
              close = false;
              pair = "''";
            };
            "\"" = {
              escape = false;
              close = false;
              pair = "\"\"";
            };
          };
        };
      };
    };
  };
}

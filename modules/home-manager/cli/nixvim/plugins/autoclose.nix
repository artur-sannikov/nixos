{
  programs = {
    nixvim = {
      plugins = {
        autoclose = {
          enable = true;
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

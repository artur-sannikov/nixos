{
  programs = {
    nixvim = {
      plugins = {
        web-devicons = {
          enable = true;
          # Small plugin, used in many places
          lazyLoad = {
            enable = false;
          };
        };
      };
    };
  };
}

{
  flake.modules.homeModules.email = {
    programs = {
      khard = {
        enable = true;
        settings = {
          general = {
            default_action = "list";
            editor = "nvim";
          };
        };
      };
    };
  };
}

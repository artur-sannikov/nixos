{
  flake.modules.homeModules.cli = {
    programs = {
      bat = {
        enable = true;
        config = {
          pager = "less -FR";
        };
      };
    };
  };
}

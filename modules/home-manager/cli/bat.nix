{
  flake.modules.homeManager.cli = {
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

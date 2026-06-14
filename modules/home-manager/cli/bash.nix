{
  flake.modules.homeManager.cli = {
    programs = {
      bash = {
        enable = true;
        historySize = 1000;
      };
    };
  };
}

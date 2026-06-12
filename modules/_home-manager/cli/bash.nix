{

  flake.modules.homeModules.cli = {
    programs = {
      bash = {
        enable = true;
        historySize = 1000;
      };
    };
  };
}

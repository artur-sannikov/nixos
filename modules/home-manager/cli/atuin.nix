{
  flake.modules.homeManager.cli = {
    programs = {
      atuin = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
      };
    };
  };
}

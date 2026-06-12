{
  flake.modules.homeModules.cli = {
    programs = {
      atuin = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
      };
    };
  };
}

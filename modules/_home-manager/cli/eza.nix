{
  flake.modules.homeModules.cli = {
    programs = {
      eza = {
        enable = true;
        enableZshIntegration = true;
        git = true;
      };
    };
  };
}

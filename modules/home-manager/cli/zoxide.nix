{
  flake.modules.homeModules.cli = {
    programs = {
      zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}

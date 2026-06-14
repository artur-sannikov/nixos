{
  flake.modules.homeManager.cli = {
    programs = {
      zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}

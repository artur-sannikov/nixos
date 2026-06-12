{
  flake.modules.homeModules.cli = {
    programs = {
      yazi = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;

        # New behavior > 26.05
        shellWrapperName = "y";
      };
    };
  };
}

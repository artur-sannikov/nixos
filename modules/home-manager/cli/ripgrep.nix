{
  flake.modules.homeModules.cli = {
    programs = {
      ripgrep = {
        enable = true;
        arguments = [ "--smart-case" ];
      };
    };
  };
}

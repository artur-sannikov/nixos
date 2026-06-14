{
  flake.modules.homeManager.cli = {
    programs = {
      ripgrep = {
        enable = true;
        arguments = [ "--smart-case" ];
      };
    };
  };
}

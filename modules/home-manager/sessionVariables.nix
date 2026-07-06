{
  flake.modules.homeManager.base = {
    # Set environment variables
    home.sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
    };
  };
}

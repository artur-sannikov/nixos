{
  programs = {
    flake.modules.homeManager.email = {
      khard = {
        enable = true;
        settings = {
          general = {
            default_action = "list";
            editor = "nvim";
          };
        };
      };
    };
  };
}

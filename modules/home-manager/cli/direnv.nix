{
  programs = {
    direnv = {
      enable = true;
      config = {
        global = {
          hide_env_diff = true;
        };
      };
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}

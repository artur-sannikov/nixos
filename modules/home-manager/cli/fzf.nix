{
  programs = {
    fzf = {
      enable = true;
      defaultOptions = [
        "--multi"
        "--height 90%"
        "--layout reverse"
        "--border rounded"
        "--info inline"
        "--margin 2%,25%,2%,25%"
        "--pointer '→'"
      ];
      enableBashIntegration = true;
      enableZshIntegration = true;
      defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    };
  };
}

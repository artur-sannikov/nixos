{
  programs = {
    fzf = {
      enable = true;
      defaultOptions = [
        "--multi"
        "--height=50%"
        "--margin=5%,2%,2%,5%"
        "--layout=reverse-list"
        "--border=double"
        "--prompt='$>''"
        "--pointer='→'"
      ];
      enableBashIntegration = true;
      enableZshIntegration = true;
      defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    };
  };
}

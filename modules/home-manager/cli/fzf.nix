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
        "--preview 'tree -C {}'"
        "--preview-window '45%,border-sharp,hidden'"
        "--bind 'ctrl-p:toggle-preview'"
      ];
      enableBashIntegration = true;
      enableZshIntegration = true;
      defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    };
  };
}

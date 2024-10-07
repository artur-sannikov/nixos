{
  # https://starship.rs/
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false;
      format = "$username$directory$git_branch$git_state$git_status";
      right_format = "$cmd_duration$time";
      username = {
        disabled = false;
        show_always = true;
        style_user = "green bold";
      };
      character = {
        success_symbol = "[↳](bold green)";
        error_symbol = "[✗](bold red)";
      };
      directory = {
        read_only = "🔒";
        truncate_to_repo = false;
      };
      time = {
        time_format = "%R";
        format = "🕙 $time($style) ";
        style = "bright-white";
        disabled = false;
      };
    };
  };
}

{ lib, ... }:
{
  flake.modules.homeManager.cli = {
    # https://starship.rs/
    programs = {
      starship = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
        settings = {
          add_newline = false;
          format = lib.concatStrings [
            "$username"
            "$hostname"
            "$directory"
            "$git_branch"
            "$git_state"
            "$git_status"
            "$nix_shell"
            "$python"
            "$conda"
            "$container"
            "$rlang"
            "$quarto"
            "$terraform"
            "\n$character"
          ];
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
          nix_shell = {
            format = "via [$symbol$state]($style) ";
            symbol = "❄️ ";
          };
          python = {
            format = "via [$symbol$pyenv_prefix($version )(\($virtualenv\) )]($style)";
            symbol = "🐍 ";
          };
        };
      };
    };
  };
}

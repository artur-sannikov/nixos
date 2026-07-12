{
  flake.modules.homeManager.cli =
    let
      esc = builtins.fromJSON ''"\u001b"'';
    in
    {
      programs = {
        fastfetch = {
          enable = true;
          settings = {
            "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

            display = {
              separator = " ";
              constants = [ "──────────────" ];
            };

            modules = [
              {
                type = "custom";
                format = "${esc}[90m  ${esc}[31m  ${esc}[32m  ${esc}[33m  ${esc}[34m  ${esc}[35m  ${esc}[36m  ${esc}[37m";
              }

              "break"

              {
                type = "custom";
                format = "{#90}┌{$1} Software {$1}{$1}┐{#}";
              }

              {
                type = "os";
                key = " ";
                keyColor = "34";
              }

              {
                type = "kernel";
                key = " ";
                keyColor = "34";
              }

              {
                type = "de";
                key = " ";
                keyColor = "34";
              }

              {
                type = "wm";
                key = " ";
                keyColor = "34";
              }

              {
                type = "shell";
                key = " ";
                keyColor = "34";
              }

              {
                type = "terminal";
                key = " ";
                keyColor = "34";
              }

              {
                type = "terminalfont";
                key = " ";
                keyColor = "34";
              }

              {
                type = "version";
                key = "{icon} ";
                keyColor = "34";
                format = "fastfetch v{version}";
              }

              {
                type = "command";
                key = " ";
                keyColor = "34";
                text = "echo nvim $(nvim --version | head -1 | awk '{print $2}')";
              }

              {
                type = "icons";
                key = " ";
                keyColor = "34";
                format = "{icons1}";
              }

              {
                type = "custom";
                format = "{#90}└{$1}────────────────────────{$1}┘{#}";
              }

              {
                type = "custom";
                format = "{#90}┌{$1} Hardware {$1}{$1}┐{#}";
              }

              {
                type = "cpu";
                key = " ";
                keyColor = "34";
                format = "{name} ({cores-physical}C/{cores-logical}T) @ {freq-max}";
              }

              {
                type = "gpu";
                key = " ";
                keyColor = "34";
                format = "{name} [{type}]";
              }

              {
                type = "display";
                key = " ";
                keyColor = "34";
              }

              {
                type = "memory";
                key = "󰍛 ";
                keyColor = "34";
              }

              {
                type = "disk";
                key = " ";
                keyColor = "34";
              }

              {
                type = "custom";
                format = "{#90}└{$1}────────────────────────{$1}┘{#}";
              }

              "break"

              {
                type = "custom";
                format = "${esc}[90m  ${esc}[31m  ${esc}[32m  ${esc}[33m  ${esc}[34m  ${esc}[35m  ${esc}[36m  ${esc}[37m";
              }

              "break"
            ];
          };
        };
      };
    };
}

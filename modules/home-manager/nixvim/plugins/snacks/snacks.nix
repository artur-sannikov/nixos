{
  flake.modules.nixvim.default = {
    plugins = {
      snacks = {
        enable = true;
        settings = {
          lazygit.enabled = false;
          bigfile.enabled = true;
          image.enabled = true;
          dashboard = {
            enabled = true;
            preset = {
              width = 40;
              keys = [
                {
                  icon = "󱪞 ";
                  key = "n";
                  desc = "New File";
                  action = ":ene | startinsert";
                }
                {
                  icon = "󰱽 ";
                  key = "fd";
                  desc = "Find File";
                  # Move from Telescope???
                  action = ":lua Snacks.picker.files()";
                }
                # {
                #   icon = "󰱽 ";
                #   key = "f";
                #   desc = "Find File";
                #   action = "<cmd>Telescope find_files<CR>";
                # }
                {
                  icon = " ";
                  key = "p";
                  desc = "Projects";
                  action = ":lua Snacks.picker.projects()";
                }
                {
                  icon = "󰈆 ";
                  key = "q";
                  desc = "Quit";
                  action = ":qa";
                  padding = 1;
                }
                {
                  icon = "󰕁 ";
                  title = "Recent Files";
                  key = "r";
                  action = "<cmd>lua Snacks.picker.recent()<CR>";
                  section = "recent_files";
                  indent = 2;
                  padding = 1;
                }
              ];
              header = ''
                   / | / /__  ____ _   __(_)___ ___
                  /  |/ / _ \/ __ \ | / / / __ `__ \
                 / /|  /  __/ /_/ / |/ / / / / / / /
                /_/ |_/\___/\____/|___/_/_/ /_/ /_/
              '';
            };
            sections = [
              { section = "header"; }
              { section = "keys"; }
            ];
          };
        };
      };
    };
  };
}

{
  flake.modules.nixvim.default = {
    plugins = {
      iron = {
        # extraConfigLua = builtins.readFile ./iron.lua;
        # luaConfig = builtins.readFile ./iron.lua;
        enable = true;
        luaConfig.post = ''
          require("iron.core").setup({
            config = {
              scratch_repl = true,

              repl_definition = {
                python = {
                  command = { "python" },
                },
                r = {
                  command = { "R" },
                },
                julia = {
                  command = { "julia" },
                },
              },

              repl_open_cmd = require("iron.view").bottom(40),
            },

            key_maps = {
              visual_send = "<leader>sc",
              send_line = "<leader>sl",
              send_file = "<leader>sf",
              toggle_repl = "<leader>rr",
            },
          })
        '';
        # settings = {
        #   scratch_repl = true;
        #   repl_definition = {
        #     r = {
        #       command = [ "radian" ];
        #     };

        # python = {
        #   command = [ "python3" ];
        #   format.__raw = ''
        #     require("iron.fts.common").bracketed_paste_python
        #   '';
        # };
        # nix = {
        #   command = [
        #     "nix"
        #     "repl"
        #   ];
        # };
      };
      # keymaps = {
      #   send_motion = "<leader>im";
      #   visual_send = "<leader>iv";
      #   send_file = "<leader>if";
      #   send_line = "<leader>il";
      #   send_paragraph = "<leader>ip";
      #   send_until_cursor = "<leader>iu";
      #   send_mark = "<leader>is";
      #   mark_motion = "<leader>ic";
      #   mark_visual = "<leader>ic";
      #   remove_mark = "<leader>id";
      #   cr = "<leader>i<cr>";
      #   interrupt = "<leader>i<space>";
      #   exit = "<leader>iq";
      #   clear = "<leader>iC";
      # };
      #   highlight = {
      #     italic = true;
      #   };
      #   ignore_blank_lines = true;
      # };
      # settings = {
      #   config = {
      #     repl_definition = {
      #       python = {
      #         command = [
      #           "python3"
      #         ];
      #         format = {
      #           __raw = "require('iron.fts.common').bracketed_paste_python";
      #         };
      #       };
      #       r = {
      #         command = [ "radian" ];
      #       };
      #       sh = {
      #         command = [
      #           "zsh"
      #         ];
      #       };
      #     };
      #     keymaps = {
      #       toggle_repl = "<leader>rs";
      #       send_motion = "<leader>im";
      #       visual_send = "<leader>rr";
      #       send_file = "<leader>if";
      #       send_line = "<leader>rr";
      #       send_paragraph = "<leader>ip";
      #       send_until_cursor = "<leader>iu";
      #       send_mark = "<leader>is";
      #       send_code_block = "<leader>sb";
      #       send_code_block_and_move = "<leader>sn";
      #       mark_motion = "<leader>ic";
      #       mark_visual = "<leader>ic";
      #       remove_mark = "<leader>id";
      #       cr = "<leader>i<cr>";
      #       interrupt = "<leader>i<space>";
      #       exit = "<leader>iq";
      #       clear = "<leader>iC";
      #     };
      #     highlight = {
      #       italic = true;
      #     };
      #     ignore_blank_lines = true;
      #   };
      # };
      # };
    };
  };
}

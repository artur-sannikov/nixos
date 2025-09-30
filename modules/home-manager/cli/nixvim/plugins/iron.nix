{
  programs.nixvim.plugins.iron = {
    enable = true;
    settings = {
      scratch_repl = true;
      R = {
        command = [ "radian" ];
      };
      r = {
        command = [ "radian" ];
      };
      quarto = {
        command = [ "radian" ];
      };
      repl_open_cmd = {
        __raw = "require(\"iron.view\").split.vertical.botright.(40)";
      };
      keymaps = {
        send_motion = "<leader>sc";
        visual_send = "<leader>sc";
        send_file = "<leader>sf";
        send_line = "<leader>sl";
        send_paragraph = "<leader>sp";
        send_until_cursor = "<leader>su";
        send_mark = "<leader>sm";
        send_code_block = "<leader>sb";
        send_code_block_and_move = "<leader>sn";
      };
    };
  };
}

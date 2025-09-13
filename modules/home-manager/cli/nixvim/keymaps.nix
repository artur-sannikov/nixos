{
  programs.nixvim = {
    keymaps = [
      {
        # Move line down
        mode = "n";
        key = "<C-j>";
        action = ":move .+1<CR>==";
      }
      {
        # Move line up
        mode = "n";
        key = "<C-k>";
        action = ">:move .-2<CR>==";
      }
      {
        # Move selected lines down
        mode = "v";
        key = "<C-j>";
        action = ":move '>+1<CR>gv=gv";
      }
      {
        # Move selected lines up
        mode = "v";
        key = "<C-k>";
        action = ":move '<-2<CR>gv=gv";
      }
    ];
  };
}

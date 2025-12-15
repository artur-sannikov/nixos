{
  programs.nixvim.plugins.markview = {
    enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>mv";
        action = "<cmd>Markview Toggle<CR>";
        options = {
          desc = "Toggle Markdown Preview";
        };
      }
    ];
  };
}

{
  programs.nixvim = {
    plugins = {
      markview = {
        enable = true;
        settings = {
          preview = {
            icon_provider = "devicons";
          };
        };
      };
    };
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

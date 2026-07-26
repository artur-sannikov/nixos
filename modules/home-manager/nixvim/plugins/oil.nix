{
  flake.modules.nixvim.default = {
    plugins = {
      oil = {
        enable = true;
        settings = {
          deleteToTrash = true;
          float = {
            padding = 2;
            maxWidth = 0;
            maxHeight = 0;
            border = "rounded";
            winOptions = {
              winblend = 0;
            };
          };
          view_options = {
            show_hidden = true;
            # See https://www.lua.org/pil/11.5.html for sets
            is_always_hidden = ''
              function(name, _)
              	local hidden_files = {
              	  [".."] = true,
                	  [".ansible"] = true,
                	  [".direnv"] = true,
                	  [".quarto"] = true,
                	  [".git"] = true,
              	}
              	return hidden_files[name] == true
              end
            '';
          };
        };
      };
    };
    keymaps = [
      {
        key = "<leader>o";
        mode = "n";
        action = ":Oil --float <CR>";
      }
    ];
  };
}

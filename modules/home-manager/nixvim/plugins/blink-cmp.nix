{
  flake.modules.nixvim.default =
    { lib, ... }:
    {
      plugins = {
        blink-cmp = {
          enable = true;
          settings = {
            enabled = lib.generators.mkLuaInline ''
              function()
                return not vim.tbl_contains({ "yaml.ansible" }, vim.bo.filetype)
              end
            '';
            snippets.preset = "luasnip"; # See luasnip plugin
            sources = {
              default = [
                "lsp"
                "path"
                "snippets"
                "buffer"
              ];
              providers = {
                latex-symbols = {
                  module = "blink-cmp-latex";
                  name = "Latex";
                  opts = {
                    insert_command = false;
                  };
                };
              };
            };
            completion = {
              ghost_text = {
                enabled = true;
              };
              documentation = {
                auto_show = true;
                auto_show_delay_ms = 500;
              };
            };
            keymap = {
              "<C-p>" = [
                "select_prev"
                "fallback_to_mappings"
              ];
              "<C-n>" = [
                "select_next"
                "fallback_to_mappings"
              ];
              "<C-d>" = [
                "scroll_documentation_down"
                "fallback_to_mappings"
              ];
              "<C-f>" = [
                "scroll_documentation_up"
                "fallback_to_mappings"
              ];
              "<C-y" = [
                "select_and_accept"
                "fallback_to_mappings"
              ];
            };
          };
          setupLspCapabilities = true;
        };
        blink-cmp-latex = {
          enable = true;
        };
      };
    };
}

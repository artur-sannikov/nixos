{
  programs.nixvim.plugins = {
    blink-cmp = {
      enable = true;
      settings = {
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
  };
}

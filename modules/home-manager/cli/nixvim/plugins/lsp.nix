{
  programs.nixvim = {
    plugins = {
      lualine.enable = true;
      lsp-format = {
        enable = true;
      };
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          # lua
          lua_ls.enable = true;

          # R
          r_language_server = {
            enable = true;
            package = null;
          };
          air = {
            enable = true;
          };

          # bash
          bashls.enable = true;

          # Python
          pylsp = {
            enable = true;
          };

          # nix
          nixd = {
            enable = true;
          };

          # Ansible
          ansiblels = {
            enable = true;
          };
        };
      };
    };
  };
}

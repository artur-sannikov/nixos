{ pkgs, ... }:
{
  programs.nixvim = {
    filetype = {
      pattern = {
        ".*\/playbooks\/.*\.ya?ml" = "yaml.ansible";
        ".*\/roles\/.*\.ya?ml" = "yaml.ansible";
        # javascript template files look better with javascript
        # parser
        ".*\.js\.j2" = "js";
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      ansible-vim
    ];
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
            filetypes = [
              "yaml.ansible"
            ];
            settings = {
              ansible = {
                path = "${pkgs.ansible}";
                useFullyQualifiedCollectionNames = true;
              };
              completion = {
                provideRedirectModules = true;
                provideModuleOptionAliases = true;
              };
              ansibleLint = {
                enabled = true;
                path = "ansible-lint";
              };
            };
          };
          yamlls = {
            enable = true;
          };
        };
      };
    };
  };
}

{
  plugins = {
    lualine = {
      enable = true;
    };
    lsp-format = {
      enable = true;
    };
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        # ansiblels = {
        #   enable = true;
        #   package = pkgs.callPackage ./ansible-language-server/package.nix { };
        #   config = {
        #     settings.ansible = {
        #       useFullyQualifiedCollectionNames = true;
        #     };
        #   };
        # };
        lua_ls = {
          enable = true;
        };

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
          settings =
            let
              flake = "(builtins.getFlake (builtins.toString ./.))";
            in
            {
              options = {
                nixos.expr = "${flake}.nixosConfigurations.desktop.options";
                home-manager.expr = "${flake}.nixosConfigurations.desktop.options.home-manager.users.type.getSubOptions []";
              };
            };
        };

        # toml
        taplo = {
          enable = true;
        };

        # typst
        tinymist = {
          enable = true;
          settings = {
            exportPdf = "onSave";
            formatterMode = "typstyle";
            formatterProseWrap = true;
            formatterPrintWidth = 80;
          };
        };

        # OpenTofu
        tofu_ls = {
          enable = true;
        };

        # yaml
        yamlls = {
          enable = true;
        };

        harper_ls = {
          enable = true;
        };
      };
    };
  };

  # lua
}

{
  flake.modules.nixvim.default = {
    plugins = {
      lint = {
        enable = true;
        lintersByFt = {
          bash = [ "shellcheck" ];
          html = [ "htmlhint" ];
          css = [ "stylelint" ];
          gitcommit = [ "codespell" ];
          dockerfile = [ "hadolint" ];
          markdown = [ "vale" ];
          nix = [
            "statix"
            "deadnix"
          ];
          python = [ "pylint" ];
          terraform = [ "tflint" ];
          text = [ "vale" ];
          yaml = [ "yamllint" ];
          "yaml.ghaction" = [ "actionlint" ];
        };
      };
    };
  };
}

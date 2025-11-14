{
  programs = {
    nixvim = {
      plugins = {
        lint = {
          enable = true;
          lintersByFt = {
            dockerfile = [ "hadolint" ];
            json = [ "jsonlint" ];
            markdown = [ "vale" ];
            nix = [
              "statix"
              "deadnix"
            ];
            python = [ "pylint" ];
            text = [ "vale" ];
            yaml = [ "yamllint" ];
          };
        };
      };
    };
  };
}

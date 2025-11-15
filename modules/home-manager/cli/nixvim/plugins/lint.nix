{
  programs = {
    nixvim = {
      plugins = {
        lint = {
          enable = true;
          lintersByFt = {
            dockerfile = [ "hadolint" ];
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

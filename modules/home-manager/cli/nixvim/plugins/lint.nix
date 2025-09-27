{
  programs.nixvim.plugins.lint = {
    enable = true;
    lintersByFt = {
      dockerfile = [ "hadolint" ];
      python = [ "pylint" ];
      json = [ "jsonlint" ];
      yaml = [ "yamllint" ];
      #      "yaml.ansible" = [ "ansible-lint" ];
    };
  };
}

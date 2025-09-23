{
  programs.nixvim.plugins.lint = {
    enable = true;
    lintersByFt = {
      dockerfile = [ "hadolint" ];
      python = [ "pylint" ];
      "yaml.ansible" = [ "ansible-lint" ];
    };
  };
}

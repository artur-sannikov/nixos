{
  programs = {
    nixvim = {
      autoCmd = [
        {
          # Remove trailing white space
          event = "BufWritePre";
          pattern = "*";
          command = ''%s/\s\+$//e'';
        }
        {
          # Disable diagnostic (linting) for Ansible files
          event = "FileType";
          pattern = "yaml.ansible";
          command = ":lua vim.diagnostic.enable(false)";
        }
      ];
    };
  };
}

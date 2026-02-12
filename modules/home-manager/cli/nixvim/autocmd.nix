{
  programs = {
    nixvim = {
      autoCmd = [
        {
          # Remove trailing whitespace
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
        {
          # Disable spellcheck in terminal mode
          event = "TermOpen";
          pattern = "*";
          command = "setlocal nospell";
        }
      ];
    };
  };
}

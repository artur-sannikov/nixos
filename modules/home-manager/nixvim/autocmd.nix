{
  flake.modules.nixvim.default = {
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
      {
        event = [
          "BufRead"
          "BufNewFile"
        ];
        pattern = [
          "*/playbooks/*.yml"
          "*/playbooks/*.yaml"
          "*/roles/*/*.yml"
          "*/roles/*/*.yaml"
          "*/group_vars/*.yml"
          "*/group_vars/*.yaml"
          "*/host_vars/*.yml"
          "*/host_vars/*.yaml"
        ];
        command = "set filetype=yaml.ansible";
      }
    ];
  };
}

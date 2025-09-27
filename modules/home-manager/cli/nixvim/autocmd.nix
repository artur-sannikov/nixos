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
      ];
    };
  };
}

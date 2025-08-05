{
  programs.nixvim.plugins = {
    no-neck-pain = {
      enable = true;
      settings = {
        width = 150;
        autocmds = {
          enableOnVimEnter = true;
          enableOnTabEnter = true;
          skipEnteringNoNeckPainBuffer = true;
        };
      };
    };
  };
}

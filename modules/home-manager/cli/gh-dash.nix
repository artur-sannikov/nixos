{
  programs = {
    gh-dash = {
      enable = true;
      settings = {
        prSections = [
          {
            title = "My Pull Requests";
            filters = "is:open author:@me";
            layout.author.hidden = true;
          }
          {
            title = "Needs My Review";
            filters = "is:open review-requested:@me";
          }
          {
            title = "Involved";
            filters = "is:open involves:@me -author:@me";
          }
        ];
        defaults = {
          preview = {
            open = true;
            width = 80;
          };
        };
        keybindings = {
          prs = [
            {
              key = "O";
              name = "edit PR";
              command = ''
                nvim -c ":Octo pr edit {{.PrNumber}}"
              '';
            }
          ];
        };
      };
    };
  };
}

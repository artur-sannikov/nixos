{
  programs = {
    iamb = {
      enable = true;
      settings = {
        profiles.user.user_id = "@liberty5804:matrix.org";
        layout.style = "restore";
        image_preview.protocol = {
          type = "kitty";
          size = {
            height = 10;
            width = 66;
          };
        };
      };
    };
  };
}

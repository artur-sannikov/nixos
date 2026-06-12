{
  flake.modules.homeModules.cli = { pkgs-stable, ... }: {
    programs = {
      iamb = {
        enable = true;
        package = pkgs-stable.iamb;
        settings = {
          profiles.user.user_id = "@liberty5804:matrix.org";
          layout.style = "restore";
          notifications = {
            enable = true;
          };
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
  };
}

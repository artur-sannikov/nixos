{
  programs.firefox = {
    enable = true;
    profiles = {
      default-release = {
        isDefault = true;
        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";
        };
      };
      tidal-hifi = {
        isDefault = false;
        id = 1;
        bookmarks = {
          force = true;
          settings = [
            {
              name = "tidal";
              url = "https://listen.tidal.com/";
            }
          ];
        };
        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";
        };
      };
      violentmonkey = {
        isDefault = false;
        id = 2;
        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";
        };
      };
    };
  };
  stylix.targets.firefox.profileNames = [
    "default-release"
  ];
}

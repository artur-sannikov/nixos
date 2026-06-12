{
  flake.modules.homeModules.gui = {
    services = {
      nextcloud-client = {
        enable = true;
        startInBackground = true;
      };
    };
  };
}

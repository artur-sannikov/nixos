{
  flake.modules.homeManager.gui = {
    services = {
      nextcloud-client = {
        enable = true;
        startInBackground = true;
      };
    };
  };
}

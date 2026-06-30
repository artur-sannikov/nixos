{
  flake.modules.homeManager.gui = { pkgs, ... }: {
    programs = {
      chromium = {
        enable = true;
        commandLineArgs = [
          "--enable-features=UseOzonePlatform"
          "--ozone-platform=wayland"
          "--no-default-browser-check"
          "--disable-pings"
        ];
      };
    };
  };
}

{
  flake.modules.homeModules.gui = { pkgs, ... }: {
    programs = {
      chromium = {
        enable = true;
        package = pkgs.brave;
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

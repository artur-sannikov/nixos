{ pkgs, ... }:
{
  flake.modules.homeModules.gui = {
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

{ pkgs, flake-inputs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    policies = {
      DontCheckDefaultBrowser = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
    };
    profiles = {
      default-release = {
        extensions = with flake-inputs.firefox-extensions.packages.${pkgs.system}; [
          ublock-origin
          bitwarden
          libredirect
        ];
        search = {
          force = true;
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
        };
        settings = {
          "browser.toolbars.bookmarks.visibility" = "always";
          "privacy.clearOnShutdown.history" = true;
          "privacy.clearOnShutdown.cookies" = true;
          "privacy.clearOnShutdown.downloads" = true;
          "privacy.clearOnShutdown.openWindows" = true;
        };
      };
    };
  };
}

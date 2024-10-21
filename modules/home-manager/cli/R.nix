{ pkgs-unstable, config, ... }:
with pkgs-unstable;
let
  R-with-packages = rWrapper.override {
    packages = with rPackages; [
      languageserver
      lintr
      styler
    ];
  };
in
{
  home.packages = [ R-with-packages ];

  # Deploy RStudio preferences files
  home.file = {
    ".config/rstudio/rstudio-prefs.json" = {
      source = config.lib.file.mkOutOfStoreSymlink ../dotfiles/rstudio-prefs.json;
    };
  };
}

{ pkgs-unstable, ... }:
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
}

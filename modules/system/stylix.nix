{ pkgs, lib, ... }:
# System-wide stylix configuration
# Home manager stylix configuration is in a separate file
{
  stylix = {
    enable = true;
    targets = {
      qt = {
        platform = lib.mkDefault "qtct";
      };
    };
    image = ./scarlet_tree.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    cursor = {
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Nord)";
      size = 32;
    };
    opacity = {
      terminal = 0.95;
    };
  };
}

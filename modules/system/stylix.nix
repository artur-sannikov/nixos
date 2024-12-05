{ pkgs, ... }:
# System-wide stylix configuration
# Home manager stylix configuration is in a separate file
{
  stylix = {
    enable = true;
    image = ./scarlet_tree.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    cursor = {
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Nord)";
    };
    fonts = {
      monospace = {
        package = pkgs.iosevka;
        name = "Iosevka Medium Extended";
      };
    };
    opacity = {
      terminal = 0.95;
    };
  };
}

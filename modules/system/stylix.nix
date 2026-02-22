{ pkgs, ... }:
# System-wide stylix configuration
# Home manager stylix configuration is in a separate file
{
  stylix = {
    enable = true;
    targets = {
      # Explicitly enable fonts
      fontconfig = {
        enable = true;
      };
    };
    fonts = rec {
      sizes = {
        applications = 14;
        terminal = 14;
      };
      serif = {
        name = "UbuntuSans Nerd Font";
        package = pkgs.nerd-fonts.ubuntu-sans;
      };
      sansSerif = serif;
      monospace = {
        name = "Iosevka Nerd Font Mono";
        package = pkgs.nerd-fonts.iosevka;
      };
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
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

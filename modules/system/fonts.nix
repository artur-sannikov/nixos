{ pkgs-stable, ... }:
{
  fonts = {
    fontconfig = {
      useEmbeddedBitmaps = true;
      defaultFonts = {
        monospace = [
          "Iosevka Term"
        ];
        sansSerif = [
          "Noto Sans"
          "DejaVu Sans"
        ];
        serif = [
          "Noto Serif"
          "DejaVu Serif"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
    enableDefaultPackages = true;
    fonts.packages = with pkgs-stable; [
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      nerd-fonts.sauce-code-pro
      font-awesome
      dejavu_fonts
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      source-code-pro
      open-sans
      liberation_ttf
      roboto
    ];
  };
}

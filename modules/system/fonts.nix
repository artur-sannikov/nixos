{ pkgs-stable, ... }:
{
  fonts = {
    fontconfig = {
      useEmbeddedBitmaps = true;
    };
    enableDefaultPackages = true;
    packages = with pkgs-stable; [
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      nerd-fonts.sauce-code-pro
      font-awesome
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      source-code-pro
      open-sans
      liberation_ttf
      roboto
    ];
  };
}

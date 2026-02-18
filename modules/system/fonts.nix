{ pkgs-stable, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs-stable; [
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      nerd-fonts.ubuntu-sans
      nerd-fonts.sauce-code-pro
      nerd-fonts.jetbrains-mono
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

{
  flake.modules.nixos.fonts = { pkgs, ... }: {
    fonts = {
      enableDefaultPackages = true;
      fontconfig = {
        useEmbeddedBitmaps = true;
      };
      packages = with pkgs.stable; [
        dejavu_fonts
        font-awesome
        liberation_ttf
        nerd-fonts.iosevka
        nerd-fonts.iosevka-term
        nerd-fonts.jetbrains-mono
        nerd-fonts.sauce-code-pro
        nerd-fonts.ubuntu-sans
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        open-sans
        roboto
        source-code-pro
      ];
    };
  };
}

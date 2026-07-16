{ inputs, ... }:
{
  flake = {
    modules = {
      nixos.stylix = { pkgs, ... }: {
        imports = [ inputs.stylix.nixosModules.stylix ];
        stylix = {
          enable = true;
          image = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/landscapes/Cloudsday.jpg";
            hash = "sha256-+EkcQlbWPGud6dvRNqB+yRe8T1UsNAenwrLgFLy3G2A=";
          };
          targets = {
            # Explicitly enable fonts
            fontconfig = {
              enable = true;
            };
          };
          fonts = rec {
            sizes = {
              applications = 16;
              terminal = 16;
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
          icons = {
            enable = true;
            package = pkgs.papirus-icon-theme;
            dark = "Papirus-Dark";
            light = "Papirus-Light";
          };
          base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
          cursor = {
            package = pkgs.capitaine-cursors-themed;
            name = "Capitaine Cursors (Nord)";
            size = 32;
          };
          opacity = {
            terminal = 0.85;
            desktop = 0.85;
          };
        };
      };
      homeManager.stylix = {
        stylix = {
          targets = {
            nixvim = {
              enable = false;
            };
          };
        };
        home = {
          pointerCursor = {
            enable = true;
          };
        };
      };
    };
  };
}

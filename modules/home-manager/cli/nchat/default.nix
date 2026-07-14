{

  flake.modules.homeManager.cli-personal =
    { pkgs, ... }:
    let
      catppuccinMochaThemeOriginal = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/d99kris/nchat/refs/heads/master/themes/catppuccin-mocha/color.conf";
        hash = "sha256-HJ/VakkLBKjuCXXdJ7DHVRXK742bpAaCdbG8KYsXb1M=";
      };

      catppuccinMochaTheme = pkgs.runCommand "color.conf" { } ''
        # ${pkgs.gnused}/bin/sed 's/^default_color_bg=0x1e1e2e$/default_color_bg=/' \ # Make the background transparent
        #   ${catppuccinMochaThemeOriginal} > $out # See the solution here: https://discourse.nixos.org/t/can-i-change-lines-in-files-i-take-from-the-nix-store/55794
          sed 's/^default_color_bg=0x1e1e2e$/default_color_bg=/' \
            ${catppuccinMochaThemeOriginal} > "$out"
      '';
    in
    {
      home.packages = with pkgs; [ nchat ];
      xdg.configFile = {
        "nchat/app.conf".source = ./app.conf;
        "nchat/color.conf".source = catppuccinMochaTheme;
        "nchat/key.conf".source = ./key.conf;
        #   "nchat/ui.conf".source = ./ui.conf;
      };
    };
}

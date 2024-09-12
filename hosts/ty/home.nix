{
  flake-inputs,
  username,
  pkgs,
  ...
}:

{
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05";
  };

  # Import modules
  imports = [
    ../../modules/home-manager/cli/default.nix
    ../../modules/home-manager/cli/bash.nix
    ../../modules/home-manager/cli/direnv.nix
    ../../modules/home-manager/cli/git.nix
    ../../modules/home-manager/cli/nix.nix
    ../../modules/home-manager/cli/packages.nix
    ../../modules/home-manager/cli/R.nix
    ../../modules/home-manager/cli/starship.nix
    ../../modules/home-manager/gui/work.nix
    flake-inputs.flatpaks.homeManagerModules.nix-flatpak
  ];

  # Enable zsh
  zsh.enable = true;

  # Enable Catppuccin theme globally
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "blue";
  };

  programs.home-manager.enable = true;
  # Set environment variables
  home.sessionVariables = {
    EDITOR = "nano";
    LC_TIME = "fi_FI.utf8";
  };

  # Stylix
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    fonts = {
      sizes.applications = 10;
    };
    image = ./scarlet_tree.png;
    targets = {
      vscode.enable = false;
    };
  };
}

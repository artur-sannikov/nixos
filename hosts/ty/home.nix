{
  flake-inputs,
  pkgs,
  username,
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
    # CLI apps
    ../../modules/home-manager/cli/default.nix

    # Work GUI apps
    ../../modules/home-manager/gui/work.nix
    ../../modules/home-manager/gui/alacritty.nix

    # ../../modules/home-manager/desktop_entries.nix
    ../../modules/home-manager/cli/nixvim.nix
    ../../modules/home-manager/services/ollama.nix
    ../../modules/home-manager/sessionVariables.nix
    ../../modules/home-manager/gui/fonts.nix

    ../../modules/home-manager/services/duplicacy-web.nix
  ];

  # Enable zsh
  zsh.enable = true;

  # Enable Catppuccin theme globally
  #catppuccin = {
  #  enable = true;
  #  flavor = "mocha";
  #  accent = "blue";
  #  vscode.enable = false;
  #};

  programs.home-manager.enable = true;
}

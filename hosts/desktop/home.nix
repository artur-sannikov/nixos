{ pkgs, ... }:
{
  home = {
    username = "artur";
    homeDirectory = "/home/artur";
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  # home.packages = with pkgs; [
  #   mat2
  #   devbox
  #   gnumake
  #   quarto
  #   nixfmt-rfc-style
  #   qt6.qtwayland
  #   kdePackages.kate
  # ];

  # Import modules
  imports = [
    ../../modules/home-manager/cli/default.nix
    ../../modules/home-manager/cli/media.nix
    ../../modules/home-manager/cli/bash.nix
    ../../modules/home-manager/cli/direnv.nix
    ../../modules/home-manager/cli/git.nix
    ../../modules/home-manager/cli/nix.nix
    ../../modules/home-manager/cli/packages.nix
    ../../modules/home-manager/cli/starship.nix
    ../../modules/home-manager/cli/gnupg.nix
    ../../modules/home-manager/cli/btop.nix
    ../../modules/home-manager/cli/fastfetch.nix
    ../../modules/home-manager/gui/personal.nix
    ../../modules/home-manager/gui/mpv.nix
    ../../modules/home-manager/cli/nixvim.nix
    # Systemd services
    ../../modules/home-manager/services/lorri.nix
    ../../modules/home-manager/services/kdeconnect.nix
    ../../modules/home-manager/services/ollama.nix
    ../../modules/home-manager/services/duplicacy-web.nix
    ../../modules/home-manager/sessionVariables.nix

    # Alacritty is supported on non-NixOS systems with caveats
    ../../modules/home-manager/gui/alacritty.nix

    ../../modules/home-manager/cli/tmux.nix

    ../../modules/home-manager/desktop_entries.nix
    ../../modules/home-manager/sessionVariables.nix
  ];

  # Enable zsh
  zsh.enable = true;

  # Enable yt-dlp
  yt-dlp.enable = true;

  programs.home-manager.enable = true;
  # Set environment variables
}

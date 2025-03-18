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
    # CLI programs
    ../../modules/home-manager/cli/default.nix

    # GUI programs
    ../../modules/home-manager/gui/common.nix
    ../../modules/home-manager/gui/personal.nix
    ../../modules/home-manager/gui/alacritty.nix

    # Systemd services
    ../../modules/home-manager/services/lorri.nix
    ../../modules/home-manager/services/kdeconnect.nix
    ../../modules/home-manager/services/duplicacy-web.nix

    # Other home-manager configuration
    ../../modules/home-manager/sessionVariables.nix
    ../../modules/home-manager/desktop_entries.nix
  ];

  # Enable zsh
  zsh.enable = true;

  # Enable yt-dlp
  yt-dlp.enable = true;

  programs.home-manager.enable = true;
}

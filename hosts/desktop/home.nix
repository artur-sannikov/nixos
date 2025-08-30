{ username, lib, ... }:
{
  home = {
    username = "${username}";
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
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "modules/home-manager/core/sops.nix"

      # CLI programs
      "modules/home-manager/cli/default.nix"
      "modules/home-manager/cli/nixvim/default.nix"

      # GUI programs
      "modules/home-manager/gui/common.nix"
      "modules/home-manager/gui/personal.nix"
      "modules/home-manager/gui/alacritty.nix"

      # Systemd services
      "modules/home-manager/services/kdeconnect.nix"
      "modules/home-manager/services/duplicacy-web.nix"

      # Other home-manager configuration
      "modules/home-manager/sessionVariables.nix"
      "modules/home-manager/desktop_entries.nix"
      "modules/home-manager/stylix.nix"
    ])
  ];

  # Enable zsh
  zsh.enable = true;

  # Enable yt-dlp
  yt-dlp.enable = true;

  programs.home-manager.enable = true;
}

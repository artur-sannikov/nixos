{
  flake.modules.homeManager.base = {
    # Set environment variables
    home.sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";

      # Enable Wayland for Electron apps
      NIXOS_OZONE_WL = "1";

      # Enable Wayland for Qt apps
      QT_QPA_PLATFORM = "wayland";
    };
  };
}

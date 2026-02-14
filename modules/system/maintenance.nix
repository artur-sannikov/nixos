{
  system = {
    autoUpgrade = {
      # Managed via flake.lock
      enable = false;
    };
  };
  nix = {
    settings = {
      # Runs at rebuild, slow
      auto-optimise-store = false;
    };
    # Hard link identical files in nix store
    optimise = {
      automatic = true;
      dates = [ "15:00" ];
    };
    gc = {
      automatic = true;
      dates = [ "9:00" ];
      options = "--delete-older-than 30d";
    };
  };
}

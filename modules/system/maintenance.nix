{
  flake.modules.nixosModules.nix-maintenance = {
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
        dates = [ "18:00" ];
      };
      gc = {
        automatic = true;
        dates = [ "weekly" ];
        options = "--delete-older-than 30d";
      };
    };
  };
}

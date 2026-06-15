{
  flake.modules.nixos.networkmanager = {
    networking = {
      networkmanager = {
        enable = true;
      };
    };
    users = {
      users = {
        artur = {
          extraGroups = [
            "networkmanager"
          ];
        };
      };
    };
  };
}

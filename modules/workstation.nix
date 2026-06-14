{ inputs, self, ... }:
{
  flake.modules.nixos.workstation = {
    imports = with inputs.self.modules.nixos; [
      cli
      home-manager
    ];
    users = {
      users = {
        artur = {
          extraGroups = [
            "input"
            "networkmanager"
          ];
        };
      };
    };
    home-manager.users.artur.imports = with self.modules.homeManager; [
      accounts
      email
      sops
    ];
  };
}

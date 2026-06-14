{ inputs, self, ... }:
{
  flake.modules.nixos.workstation-personal = {
    imports = with inputs.self.modules.nixos; [
      cli
      gaming
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
      email-personal
      gui-personal
      sops
    ];
  };
}

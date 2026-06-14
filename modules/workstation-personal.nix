{ inputs, self, ... }:
{
  flake.modules.nixos.workstation-personal = {
    imports = with inputs.self.modules.nixos; [
      workstation # Common stuff between personal and work
      gaming
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
      email-personal
      gui-personal
    ];
  };
}

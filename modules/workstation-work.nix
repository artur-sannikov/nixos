{ inputs, self, ... }:
{
  flake.modules.nixos.workstation-work = {
    imports = with inputs.self.modules.nixos; [
      workstation # Common stuff between personal and work
      samba # For printing and stuff
      xremap
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
      gui-work
    ];
  };
}

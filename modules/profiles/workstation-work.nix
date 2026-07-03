{ inputs, self, ... }:
{
  flake.modules.nixos.workstation-work = {
    imports = with inputs.self.modules.nixos; [
      llama-cpu
      workstation # Common stuff between personal and work
      samba # For printing and stuff
      xremap
    ];
    home-manager.users.artur.imports = with self.modules.homeManager; [
      gui-work
    ];
  };
}

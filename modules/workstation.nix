{ inputs, ... }:
{
  flake.modules.nixos.workstation = {

    imports = with inputs.self.modules.nixos; [ cli ];
    users = {
      users = {
        artur = {
          extraGroups = [
            "inputs"
            "networkmanager"
          ];
        };
      };
    };
  };
}

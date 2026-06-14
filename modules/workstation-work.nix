{ inputs, ... }:
{
  flake.modules.nixos.workstation-work = {
    imports = with inputs.self.modules.nixos; [
      email
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
  };
}

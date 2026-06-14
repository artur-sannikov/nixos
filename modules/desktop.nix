{ inputs, ... }:
{
  flake.modules.nixos.desktop = {
    imports = with inputs.self.modules.nixos; [
      lact # Videocard tweaking
      ratbagd # Mouse setup
    ];
  };
}

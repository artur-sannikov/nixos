{ inputs, ... }:
{
  flake.modules.nixos.laptop = {
    imports = with inputs.self.modules.nixos; [
      timezone-dynamic
      wifi-privacy
    ];
  };
}

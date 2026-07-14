# Add Nix user repository https://github.com/nix-community/NUR
{ inputs, ... }:
{
  flake.modules.nixos.nur = {
    imports = [
      inputs.nur.modules.nixos.default
    ];
  };
}

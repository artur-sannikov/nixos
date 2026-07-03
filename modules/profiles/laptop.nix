{ inputs, ... }:
{
  flake.modules.nixos.laptop = {
    imports = with inputs.self.modules.nixos; [
      llama-cpu
      timezone-dynamic
      wifi-privacy
      printing
    ];
  };
}

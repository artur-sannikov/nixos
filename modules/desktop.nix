{ inputs, ... }:
{
  flake.modules.nixos.desktop = {
    imports = with inputs.self.modules.nixos; [
      corectrl
      lact # Videocard tweaking
      ollama-rocm # Accelerate with AMD
      ratbagd # Mouse setup
    ];
    nixpkgs.config.rocmSupport = true;
  };
}

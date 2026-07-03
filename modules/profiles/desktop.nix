{ inputs, ... }:
{
  flake.modules.nixos.desktop = {
    imports = with inputs.self.modules.nixos; [
      corectrl
      lact # Videocard tweaking
      ollama-rocm # Accelerate with AMD
      llama-rocm
      ratbagd # Mouse setup
      openrgb
      immich-machine-learning

      # Desktop does not need automatic timezone
      timezone-static
    ];
    nixpkgs = {
      config = {
        rocmSupport = true;
      };
    };
  };
}

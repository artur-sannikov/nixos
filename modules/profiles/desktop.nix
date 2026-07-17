{ inputs, ... }:
{
  flake.modules = {
    nixos = {
      desktop = {
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
    };
    homeManager.desktop = {
      programs.niri.settings = {
        outputs."DP-2" = {
          variable-refresh-rate = false; # Causes flickering
          mode = {
            width = 3840;
            height = 2160;
            refresh = 239.990;
          };
        };
      };
    };
  };
}

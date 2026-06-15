{
  flake.modules.nixos.amdgpu = {
    hardware = {
      amdgpu = {
        overdrive = {
          enable = true;
        };
      };
    };
  };
}

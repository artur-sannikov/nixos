{
  flake.modules.nixos.immich-machine-learning = {
    virtualisation.oci-containers = {
      backend = "podman";
      containers = {
        immich-machine-learning = {
          image = "ghcr.io/immich-app/immich-machine-learning:release-rocm";
          ports = [
            "3003:3003"
          ];
          volumes = [
            "immich-machine-learning:/cache"
          ];
          extraOptions = [
            "--device=/dev/kfd"
            "--device=/dev/dri"
            "--group-add=video"
          ];
        };
      };
    };
    networking = {
      firewall = {
        allowedTCPPorts = [
          3003
        ];
      };
    };
  };
}

{ username, ... }:
{
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      immich-machine-learning = {
        # image = "ghcr.io/mmich-app/immich-machine-learning:v1.124.2";
        image = "ghcr.io/immich-pytorch-rocm:latest";
        ports = [
          "3003:3003"
        ];
        volumes = [
          "immich-machine-learning:/cache"
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
}

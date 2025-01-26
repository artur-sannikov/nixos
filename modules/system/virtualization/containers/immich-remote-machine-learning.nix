{ username, ... }:
{
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      immich-machine-learning = {
        image = "ghcr.io/immich-app/immich-machine-learning:v1.124.2";
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

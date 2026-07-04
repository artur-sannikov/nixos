{
  flake.modules.nixos.metube =
    { username, ... }:
    {
      virtualisation.oci-containers.containers.metube = {
        image = "ghcr.io/alexta69/metube:latest";

        ports = [
          "8081:8081"
        ];

        volumes = [
          "/home/${username}/podman/metube/downloads:/downloads"
        ];

        environment = {
          DOWNLOAD_DIR = "/downloads";
        };

        autoStart = true;
      };
    };
}

{ username, ... }:
{
  virtualisation.oci-containers.containers = {
    sillytavern = {
      image = "ghcr.io/sillytavern/sillytavern:latest";
      extraOptions = [
        "--network=host"
      ];
      ports = [ "8000" ];
      volumes = [
        "/home/${username}/podman/sillytavern/config:/home/node/app/config"
        "/home/${username}/podman/sillytavern/data:/home/node/app/data"
      ];
    };
  };
}

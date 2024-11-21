{ username, ... }:
{
  systemd.tmpfiles.rules = [
    "d /home/${username}/podman/sillytavern/config 0750 ${username} users -"
    "d /home/${username}/podman/sillytavern/data 0750 ${username} users -"
    "d /home/${username}/podman/comfy-ui/storage 0750 ${username} users -"
  ];

  virtualisation.oci-containers.containers = {
    sillytavern = {
      image = "ghcr.io/sillytavern/sillytavern:latest";
      extraOptions = [
        "--network=host"
      ];
      volumes = [
        "/home/${username}/podman/sillytavern/config:/home/node/app/config"
        "/home/${username}/podman/sillytavern/data:/home/node/app/data"
      ];
    };
  };
}

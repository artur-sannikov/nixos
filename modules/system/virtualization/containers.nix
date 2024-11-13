{ username, ... }:
{
  virtualisation.oci-containers.containers.sillytavern = {
    image = "goolashe/sillytavern:latest";
    extraOptions = [
      "--network=host"
    ];
    ports = [ "8000" ];
    volumes = [
      "/home/${username}/podman/sillytavern/config:/home/node/app/config"
      "/home/${username}/sillytavern/user:/home/node/app/public/user"
    ];
  };
}

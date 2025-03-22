{
  config,
  lib,
  username,
  ...
}:
with lib;
let
  cfg = config.modules.system.virtualisation.containers.sillytavern;
in
{
  options.modules.system.virtualisation.containers.sillytavern = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Silly Tavern";
    };
  };
  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d /home/${username}/podman/sillytavern/config 0750 ${username} users -"
      "d /home/${username}/podman/sillytavern/data 0750 ${username} users -"
      "d /home/${username}/podman/comfy-ui/storage 0750 ${username} users -"
    ];

    virtualisation.oci-containers = {
      backend = "podman";
      containers = {
        sillytavern = {
          image = "ghcr.io/sillytavern/sillytavern:latest";
          ports = [
            "8000:8000"
          ];
          labels = {
            "io.containers.autoupdate" = "registry";
          };
          volumes = [
            "/home/${username}/podman/sillytavern/config:/home/node/app/config"
            "/home/${username}/podman/sillytavern/data:/home/node/app/data"
          ];
        };
      };
    };
  };
}

{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.system.virtualisation.containers.immich-remote-machine-learning;
in
{
  options.modules.system.virtualisation.containers.immich-remote-machine-learning = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Immich Remote Machine Learning";
    };
  };
  config = mkIf cfg.enable {
    virtualisation.oci-containers = {
      backend = "podman";
      containers = {
        immich-machine-learning = {
          image = "ghcr.io/immich-app/immich-machine-learning:v1.129.0";
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
  };
}

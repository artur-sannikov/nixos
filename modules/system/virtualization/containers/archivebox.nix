{
  config,
  lib,
  username,
  ...
}:
with lib;
let
  cfg = config.modules.system.virtualisation.containers.archivebox;
in
{
  options.modules.system.virtualisation.containers.archivebox = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Archivebox";
    };
  };
  config = mkIf cfg.enable {
    virtualisation.oci-containers = {
      backend = "docker";
      containers = {
        archivebox = {
          image = "archivebox/archivebox:latest";
          ports = [
            "8000:8000"
          ];
          extraOptions = [ "--security-opt no-new-privileges" ];
          environment = {
            ALLOWED_HOSTS = "*";
            CSRF_TRUSTED_ORIGINS = archiveboxUrl;
            PGID = "1004";
            PUBLIC_INDEX = False;
            PUBLIC_SNAPSHOTS = False;
            PUBLIC_ADD_VIEW = False;
            MEDIA_MAX_SIZE = 750 m;
            TIMEOUT = 300;
            SAVE_ARCHIVE_DOT_ORG = True;
          };
          volumes = [
            "/mnt/nas/archive:/data:rw"
          ];
        };
      };
    };
  };
}

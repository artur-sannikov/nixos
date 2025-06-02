{
  config,
  lib,
  username,
  flake-inputs,
  ...
}:
with lib;
let
  cfg = config.modules.system.virtualisation.containers.archivebox;
  archiveboxUrl = "https://archive.${flake-inputs.nix-secrets.domain}";
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
          image = "docker.io/archivebox/archivebox:latest";
          ports = [
            "8000:8000"
          ];
          extraOptions = [ "--security-opt=no-new-privileges" ];
          environment = {
            ALLOWED_HOSTS = "*";
            CSRF_TRUSTED_ORIGINS = archiveboxUrl;
            PGID = "1004";
            PUBLIC_INDEX = "False";
            PUBLIC_SNAPSHOTS = "False";
            PUBLIC_ADD_VIEW = "False";
            MEDIA_MAX_SIZE = "750m";
            TIMEOUT = "300";
            SAVE_ARCHIVE_DOT_ORG = "True";
          };
          volumes = [
            "/home/${username}/docker/appdata/archivebox/data:/data"
            "/mnt/nas/archivebox:/data/archive"
          ];
        };
      };
    };
  };
}

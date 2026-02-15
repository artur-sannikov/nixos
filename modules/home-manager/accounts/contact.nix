{
  config,
  flake-inputs,
  pkgs,
  username,
  ...
}:
let
  carddav_url = "https://nextcloud.${flake-inputs.nix-secrets.domain}/remote.php/dav/addressbooks/users/${username}/default/";
in
{
  accounts = {
    contact = {
      basePath = ".contacts";
      accounts = {
        default = {
          khard = {
            enable = true;
          };
          pimsync = {
            enable = true;
          };
          local = {
            type = "filesystem";
            fileExt = ".vcf";
          };
          remote = {
            passwordCommand = [
              "${pkgs.coreutils}/bin/cat"
              config.sops.secrets."pimsync/nextcloud/password".path
            ];
            type = "carddav";
            url = carddav_url;
            userName = "${username}";
          };
        };
      };
    };
  };
  programs = {
    pimsync = {
      enable = true;
      settings = [
        {
          name = "status_path";
          params = [ "${config.xdg.dataHome}/pimsync/status" ];
        }
      ];
    };
  };
  services = {
    pimsync = {
      enable = true;
    };
  };
}

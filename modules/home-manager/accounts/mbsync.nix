{
  config,
  lib,
  pkgs,
  ...
}:
let
  commonMbsyncConfig = {
    enable = true;
    create = "both";
    expunge = "both";
    extraConfig = {
      account = {
        AuthMechs = "LOGIN";
        TLSType = "IMAPS";
        Timeout = 60;
      };
    };
  };
in
{
  accounts = {
    email = {
      accounts = {
        migadu = {
          mbsync = lib.recursiveUpdate commonMbsyncConfig {
            extraConfig = {
              account = {
                PassCmd = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.migadu_password.path}";
                Host = "imap.migadu.com";
              };
            };
          };
        };
        work = {
          mbsync = lib.recursiveUpdate commonMbsyncConfig {
            extraConfig = {
              account = {
                PassCmd = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.utu_password.path}";
                Host = "mail.utu.fi";
              };
            };
          };
        };
      };
    };
  };
  services = {
    mbsync = {
      enable = true;
      # Index new emails
      postExec = ''
        ${pkgs.notmuch}/bin/notmuch new
      '';
    };
  };
  programs = {
    mbsync = {
      enable = true;
    };
  };
}

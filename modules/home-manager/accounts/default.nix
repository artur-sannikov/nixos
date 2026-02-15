{
  config,
  flake-inputs,
  pkgs,
  ...
}:
let
  utu_email = "${flake-inputs.nix-secrets.utu_email}";
  migadu_email = "${flake-inputs.nix-secrets.migadu_email}";
in
{
  sops = {
    secrets = {
      utu_password = { };
      migadu_password = { };
      "pimsync/nextcloud/password" = { };
    };
  };
  imports = [
    ./contact.nix
    ./khard.nix
    ./mbsync.nix
    ./msmtp.nix
    ./neomutt
    ./notmuch.nix
    ./thunderbird.nix
  ];
  accounts = {
    email = {
      accounts = {
        migadu = rec {
          primary = false;
          flavor = "migadu.com";
          address = migadu_email;
          userName = address;
          realName = "Artur Sannikov";
          passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.migadu_password.path}";
          imap = {
            host = "imap.migadu.com";
            port = 993;
            tls.enable = true;
          };
          smtp = {
            host = "smtp.migadu.com";
            port = 465;
          };
        };
        work = rec {
          primary = true;
          address = utu_email;
          userName = address;
          realName = "Artur Sannikov";
          signature = {
            text = ''
              Artur Sannikov
              Doctoral Researcher
              Food Sciences Unit, Department of Life Technologies
              University of Turku, Finland
            '';
            showSignature = "append";
          };
          passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.utu_password.path}";
          gpg = {
            key = "4653F089E0C1F62F4AB8FF09C76C0C265540AEF2";
            encryptByDefault = false;
            signByDefault = true;
          };
          imap = {
            host = "mail.utu.fi";
            port = 993;
            tls = {
              enable = true;
            };
          };
          smtp = {
            host = "mail.utu.fi";
            port = 587;
            tls = {
              useStartTls = true;
            };
          };
        };
      };
    };
  };
}

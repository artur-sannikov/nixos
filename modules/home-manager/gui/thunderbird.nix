{
  pkgs,
  config,
  flake-inputs,
  ...
}:
let
  utu_email = "${flake-inputs.nix-secrets.utu_email}";
in
{
  sops = {
    secrets = {
      utu_password = { };
    };
  };
  accounts = {
    email = {
      accounts = {
        work = rec {
          primary = true;
          address = utu_email;
          userName = address;
          realName = "Artur Sannikov";
          passwordCommand = " ${pkgs.coreutils}/bin/cat ${config.sops.secrets.utu_password.path}";
          imap = {
            host = "mail.utu.fi";
            port = 993;
            tls.enable = true;
          };
          smtp = {
            host = "mail.utu.fi";
            port = 587;
            tls = {
              useStartTls = true;
            };
          };
          thunderbird = {
            enable = true;
            profiles = [ "work" ];
            settings = id: {
              "mail.server.server_${id}.authMethod" = 3;
            };
          };
        };
      };
    };
  };
  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird-latest;
    profiles = {
      work = {
        isDefault = true;
      };
    };
  };
}

{
  flake.modules.nixos.users-artur = { config, ... }: {
    sops = {
      secrets = {
        artur_passwd = {
          neededForUsers = true;
        };
      };
    };
    users = {
      users = {
        artur = {
          isNormalUser = true;
          hashedPasswordFile = config.sops.secrets.artur_passwd.path;
          extraGroups = [
            "wheel"
          ];
        };
      };
    };
  };
}

{
  flake.modules.nixos.users-artur = { config, pkgs, ... }: {
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
          shell = pkgs.zsh;
          extraGroups = [
            "wheel"
          ];
        };
      };
    };
  };
}

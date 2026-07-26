{
  flake.modules.nixos.virtualization = {
    virtualisation.docker = {
      # Disable system-wide docker
      enable = false;
      autoPrune = {
        enable = true;
        dates = "13:00";
      };
      # storageDriver = lib.mkDefault "btrfs";
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
  flake.modules.homeManager.virtualization = { pkgs, ... }: {
    home.packages = with pkgs; [ docker-credential-helpers ];
    programs.docker-cli = {
      enable = true;
      settings = {
        credsStore = "pass";
        credHelpers = {
          "ghcr.io" = "pass";
        };
      };
    };
  };
}

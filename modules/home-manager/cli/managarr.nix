{ inputs, ... }:
{
  flake.modules.homeModules.personal-cli =
    {
      config,
      pkgs,
      ...
    }:
    {
      sops = {
        secrets = {
          "radarr/token" = { };
          "sonarr/token" = { };
        };
      };
      home = {
        packages = with pkgs; [
          managarr
        ];
      };
      sops.templates."managarr".content = ''
        theme: default
        radarr:
          - uri: https://radarr.${inputs.nix-secrets.domain}
            api_token: "${config.sops.placeholder."radarr/token"}"
        sonarr:
          - uri: https://sonarr.${inputs.nix-secrets.domain}
            api_token: "${config.sops.placeholder."sonarr/token"}"
      '';
      xdg.configFile."managarr/config.yml".source =
        config.lib.file.mkOutOfStoreSymlink
          config.sops.templates."managarr".path;
    };
}

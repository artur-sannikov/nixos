{
  config,
  flake-inputs,
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
      - uri: https://radarr.${flake-inputs.nix-secrets.domain}
        api_token: "${config.sops.placeholder."radarr/token"}"
    sonarr:
      - uri: https://sonarr.${flake-inputs.nix-secrets.domain}
        api_token: "${config.sops.placeholder."sonarr/token"}"
  '';
  xdg.configFile."managarr/config.yml".source =
    config.lib.file.mkOutOfStoreSymlink
      config.sops.templates."managarr".path;
}

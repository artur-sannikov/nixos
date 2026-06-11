{ config, pkgs, ... }:
{
  flake.modules.homeModules.cli = {
    home = {
      packages = with pkgs; [
        chezmoi
      ];
      file = {
        "${config.xdg.configHome}/chezmoi/chezmoi.toml" = {
          text = ''
            [git]
            autoCommit = true
            autoPush = true
          '';
          executable = false;
        };
      };
    };
  };
}

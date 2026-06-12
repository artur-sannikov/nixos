{
  flake.modules.homeModules.cli = { config, pkgs, ... }: {
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

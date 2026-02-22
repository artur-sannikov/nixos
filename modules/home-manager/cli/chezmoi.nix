{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      chezmoi
    ];
    file = {
      ".config/chezmoi/chezmoi.toml" = {
        text = ''
          [git]
          autoCommit = true
          autoPush = true
        '';
        executable = false;
      };
    };
  };
}

{ pkgs-unstable, ... }:
{
  programs.thunderbird = {
    enable = true;
    package = pkgs-unstable.thunderbird;
    profiles = {
      work = {
        isDefault = true;
      };
    };
  };
}

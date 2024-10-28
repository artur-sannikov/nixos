{ pkgs-unstable, ... }:
{
  programs.thunderbird = {
    enable = true;
    package = pkgs-unstable.betterbird;
    profiles = {
      work = {
        isDefault = true;
      };
    };
  };
}

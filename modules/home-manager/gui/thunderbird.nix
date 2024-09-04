{ pkgs, ... }:
{
  programs.thunderbird = {
    enable = true;
    package = pkgs.betterbird;
    profiles = {
      work = {
        isDefault = true;
      };
    };
  };
}

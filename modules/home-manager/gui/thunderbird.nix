{ pkgs, ... }:
{
  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird;
    profiles = {
      work = {
        isDefault = true;
      };
    };
  };
}

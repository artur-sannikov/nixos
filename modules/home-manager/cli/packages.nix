{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    ansible
    ansible-lint
    pandoc
    screen
  ];
}

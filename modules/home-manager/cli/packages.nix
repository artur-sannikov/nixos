{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ansible
    ansible-lint
    pandoc
    screen
  ];
}

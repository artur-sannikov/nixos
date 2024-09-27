{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bottles
    wine64
  ];
}

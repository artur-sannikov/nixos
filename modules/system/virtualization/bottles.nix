{
  flake.modules.nixos.virtualization =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bottles
        wine64
      ];
    };
}

{
  flake.modules.nixos.virtualization =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs.stable; [
        bottles
        wine64
      ];
    };
}

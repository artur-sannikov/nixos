{ inputs, ... }:
{
  flake.lib.mkNixos =
    {
      hostName,
      system ? "x86_64-linux",
      username ? "artur",
      modules,
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit username; };
      modules = modules ++ [
        ../hosts/${hostName}/_disko.nix
        { networking.hostName = hostName; }
      ];
    };
}

{ inputs, ... }:
{
  flake.lib = inputs.nixpkgs.lib.extend (
    final: prev: { custom = import ../../lib { inherit (inputs.nixpkgs) lib; }; }
  );
}

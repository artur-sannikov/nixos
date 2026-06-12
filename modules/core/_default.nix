# {
# lib,
# importTree,
#   ...
# }:
# {
#   imports = lib.flatten [
#     (lib.custom.scanPaths ./.)
#   ];
# }
{
  imports = [
    ./sudo.nix
    ./earlyoom.nix
  ];
}
# {
#   imports = [ (importTree ./.) ];
# }

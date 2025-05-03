{
  lib,
  ...
}:
{
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      (lib.custom.scanPaths ./.)
    ])
  ];
}

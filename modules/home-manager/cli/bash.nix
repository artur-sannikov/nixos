{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    types
    mkOption
    attrsOf
    mkEnableOption
    ;

  cfg = config.nixos.bash;

  userOpts = {
    options = {
      enable = mkEnableOption "bash" // {
        default = true;
      };
    };
  };
in
{

  options.nixos.bash =
    with types;
    mkOption {
      description = "Enable bash.";
      type = attrsOf (submodule userOpts);
      default = { };
    };
  config = {
    programs = {
      bash = {
        enable = true;
        historySize = 10000;
      };
    };
  };
}

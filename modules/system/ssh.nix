{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.sshAgent;
in
{
  options.sshAgent = {
    enable = lib.mkEnableOption "sshAgent";
  };
  config = mkIf cfg.enable {
    programs = {
      ssh.startAgent = true;
    };
  };
}

{
  flake.modules.nixos.dms = {
    programs.dms-shell = {
      enable = true;
      systemd.enable = true;
    };
  };
}

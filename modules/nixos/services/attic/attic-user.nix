{
  flake.modules.nixos.attic = {
    users = {
      groups = {
        atticd = { };
      };
      users = {
        # Need atticd user for declarative storage creation
        atticd = {
          isSystemUser = true;
          group = "atticd";
          home = "/var/lib/atticd";
          createHome = true;
        };
      };
    };
  };
}

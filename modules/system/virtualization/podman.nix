{
  virtualisation = {
    podman = {
      enable = true;
      autoPrune = {
        enable = true;
        flags = [
          "--all"
        ];
      };
    };
    containers = {
      storage = {
        settings = {
          # defaults
          storage = {
            driver = "overlay";
            graphroot = "/var/lib/containers/storage";
            runroot = "/run/containers/storage";
          };
        };
      };
    };
  };
}

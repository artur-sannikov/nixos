{
  virtualisation = {
    containers.storage.settings = {
      # defaults
      storage = {
        driver = "overlay";
        graphroot = "/var/lib/containers/storage";
        runroot = "/run/containers/storage";
      };
    };
    podman = {
      enable = true;
    };
  };
}

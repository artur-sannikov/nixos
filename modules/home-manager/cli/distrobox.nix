{
  programs = {
    distrobox = {
      enable = true;
      settings = {
        container_manager = "podman";
        container_always_pull = "1";
      };
    };
  };
}

{
  virtualisation.docker = {
    # Disable system-wide docker
    enable = false;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}

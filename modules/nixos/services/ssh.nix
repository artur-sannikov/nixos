{
  flake.modules.nixos.ssh = {
    programs = {
      ssh = {
        startAgent = true;
      };
    };
    # Enables this when using Niri?
    services.gnome.gcr-ssh-agent.enable = false;
  };
}

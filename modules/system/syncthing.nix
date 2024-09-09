{ username, ... }:
{
  services.syncthing = {
    user = username;
    enable = true;
    configDir = "/home/${username}/.config/syncthing";
    # Not declarative as of now
    overrideDevices = false;
    overrideFolders = false;
    # See https://docs.syncthing.net/users/config.html#config-file-format
    settings = {
      gui = {
        theme = "dark";
      };
      options = {
        # Use Tailscale instead of relays
        natEnabled = false;
        relaysEnabled = false;
        globalAnnounceEnabled = false;
        localAnnounceEnabled = false;
        urAccepted = -1;
      };
    };
  };
}

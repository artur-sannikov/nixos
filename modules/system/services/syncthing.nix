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
        natEnabled = true;
        relaysEnabled = true;
        globalAnnounceEnabled = true;
        localAnnounceEnabled = true;
        urAccepted = -1;
      };
    };
  };
}

{
  flake.modules.nixos.metube =
    { config, username, ... }:
    {
      sops = {
        secrets = {
          "gluetun/wireguard-private-key" = { };
          "gluetun/wireguard-public-key" = { };
          "gluetun/server-hostnames" = { };
        };
        # Public key and hostname are not exactly secrets, but I keep them hidden:D
        templates."gluetun.env".content = ''
          WIREGUARD_PRIVATE_KEY=${config.sops.placeholder."gluetun/wireguard-private-key"}
          WIREGUARD_PUBLIC_KEY=${config.sops.placeholder."gluetun/wireguard-public-key"}
          SERVER_HOSTNAMES=${config.sops.placeholder."gluetun/server-hostnames"}
        '';
      };

      # Create directory
      systemd.tmpfiles.rules = [
        "d /home/${username}/podman/metube 1750 ${username} -"
        "d /home/${username}/podman/metube/downloads 1750 ${username} -"
        "d /home/${username}/podman/gluetun 1700 ${username} -"
        "d /home/${username}/podman/gluetun/config 1700 ${username} -"
      ];

      virtualisation = {
        oci-containers = {
          containers = {
            metube = {
              image = "ghcr.io/alexta69/metube:latest";
              labels = {
                "io.containers.autoupdate" = "registry";
              };
              volumes = [
                "/home/${username}/podman/metube/downloads:/downloads"
              ];
              environment = {
                DOWNLOAD_DIR = "/downloads";
              };
              networks = [ "container:gluetun" ];
              autoStart = true;
            };
            gluetun = {
              image = "ghcr.io/qdm12/gluetun:latest";
              autoStart = true;
              hostname = "gluetun";
              ports = [
                "127.0.0.1:8081:8081" # metube
              ];
              volumes = [
                "/home/${username}/podman/gluetun/config:/gluetun"
              ];
              capabilities = {
                NET_ADMIN = true;
              };
              devices = [ "/dev/net/tun:/dev/net/tun" ];
              environment = {
                VPN_SERVICE_PROVIDER = "protonvpn";
                VPN_TYPE = "wireguard";
                TZ = "Europe/Helsinki";
              };
              environmentFiles = [ config.sops.templates."gluetun.env".path ];
            };
          };
        };
      };
    };
}

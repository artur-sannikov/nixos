{
  flake.modules.homeManager.duplicacy-web =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.duplicacy-web
      ];

      systemd.user.services = {
        duplicacy-web = {
          Unit = {
            Description = "Duplicacy Web service";
            After = "network.target";
          };
          Service = {
            Type = "simple";
            ExecStart = "${pkgs.duplicacy-web}/duplicacy-web -background";
            Restart = "on-failure";

            # Hardening
            LockPersonality = true;
            NoNewPrivileges = true;
            MemoryDenyWriteExecute = true;
            PrivateDevices = true;
            PrivateMounts = true;
            PrivateTmp = true;
            ProtectClock = true;
            ProtectControlGroups = true;
            ProtectKernelLogs = true;
            ProtectKernelModules = true;
            ProtectKernelTunables = true;
            ProtectProc = "invisible";
            ProtectSystem = "strict";
            DevicePolicy = "closed";
            CapabilityBoundingSet = "";
            RemoveIPC = true;
            RestrictAddressFamilies = "AF_UNIX AF_NETLINK AF_INET AF_INET6";
            RestrictNamespaces = true;
            RestrictRealtime = true;
            RestrictSUIDSGID = true;
            SystemCallArchitectures = "native";
            SocketBindDeny = "any";
            SocketBindAllow = "tcp:3875"; # only listen on port 3875
          };
          Install = {
            WantedBy = [ "default.target" ];
          };
        };
      };
    };
}

# See https://github.com/8bitbuddhist/nix-configuration/blob/dc76c64c7c281a5ff8259a9c9aada5a30da1258c/modules/services/duplicacy-web.nix
#  Needed to remove 'inherit pkgs lib;' from callPackage for successfull build for home-manager
{ pkgs, ... }:
let
  duplicacy-web = pkgs.callPackage ./gui/duplicacy-web.nix { };
in
{
  home.packages = [
    duplicacy-web
  ];

  systemd.user.services = {
    duplicacy-web = {
      Unit = {
        Description = "Duplicacy Web service";
        After = "network.target";
      };
      Service = {
        Type = "simple";
        ExecStart = "${duplicacy-web}/duplicacy-web -background";
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

  services = {
    kdeconnect.enable = true;
    lorri.enable = true;
  };
}

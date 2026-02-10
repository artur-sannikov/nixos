{
  services = {
    openssh = {
      enable = true;
      settings = {
        Ciphers = [
          "chacha20-poly1305@openssh.com"
          "aes256-gcm@openssh.com"
          "aes256-ctr"
          "aes192-ctr"
          "aes128-gcm@openssh.com"
          "aes128-ctr"
        ];
        Macs = [
          "hmac-sha2-512-etm@openssh.com"
          "hmac-sha2-256-etm@openssh.com"
          "umac-128-etm@openssh.com"
        ];
        KexAlgorithms = [
          "mlkem768x25519-sha256"
          "sntrup761x25519-sha512"
          "sntrup761x25519-sha512@openssh.com"
          "curve25519-sha256"
          "curve25519-sha256@libssh.org"
          "diffie-hellman-group18-sha512"
          "diffie-hellman-group-exchange-sha256"
          "diffie-hellman-group16-sha512"
        ];

        # Authentication
        PermitRootLogin = "no";
        LoginGraceTime = "30s";
        StrictModes = true;
        MaxAuthTries = "3";
        MaxSessions = 10;
        MaxStartups = "10:30:60";
        IgnoreRhosts = "yes";
        IgnoreUserKnownHosts = "yes";
        HostbasedAuthentication = "no";
        AuthenticationMethods = "publickey";

        # To disable tunneled clear text passwords, change to no here!
        PermitEmptyPasswords = "no";
        PasswordAuthentication = false;

        # Network
        TCPKeepAlive = "no";
        ClientAliveInterval = 300;
        ClientAliveCountMax = 3;
        PermitTunnel = "no";
        AllowAgentForwarding = "no";
        AllowTcpForwarding = "no";
        GatewayPorts = "no";
        X11Forwarding = false;
        X11UseLocalhost = "yes";

        # Miscellaneous
        Compression = "no";
        PrintMotd = false;
        Banner = "false";

        KbdInteractiveAuthentication = false;
      };
    };
  };
  # Enable 'sudo' with SSH key
  # https://github.com/serokell/deploy-rs/issues/299
  security = {
    pam = {
      sshAgentAuth = {
        enable = true;
      };
    };
  };
}

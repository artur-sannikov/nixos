{ username, ... }:
# Probably better to write a common function to create all email accounts
let
  accountNames = [
    "work"
    "migadu"
  ];
  msmtpLogFiles = map (name: "f /home/${username}/.cache/.msmtp_${name}.log 0644 - - -") accountNames;
  mkMsmtp = name: {
    enable = true;
    # Setting the log is imperative to be able to send email...
    extraConfig = {
      logfile = "~/.cache/.msmtp_${name}.log";
    };
  };
in
{
  # Create files for cache
  systemd.user.tmpfiles.rules = msmtpLogFiles;

  # Enable msmtp for accounts
  accounts = {
    email = {
      accounts = {
        migadu = {
          msmtp = mkMsmtp "migadu";
        };
        work = {
          msmtp = mkMsmtp "work";
        };
      };
    };
  };
  programs = {
    msmtp = {
      enable = true;
    };
  };
}

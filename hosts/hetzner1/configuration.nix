{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "hosts/hetzner1/disko.nix"
      "modules/system/services/openssh.nix"
      "modules/system/maintenance.nix"
      "modules/core/default.nix"
    ])
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = false;
      };
    };
  };

  networking = {
    hostName = "hetzner1";
  };

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    git
    tmux
  ];

  sops = {
    secrets = {
      secrets = {
        "keys/ssh/hetzner1-authorized-keys/authorized-keys" = {
          path = "/home/${username}/.ssh/authorized_keys";
        };

      };
      artur_passwd = {
        neededForUsers = true;
      };
    };
  };

  users = {
    mutableUsers = false;
    users = {
      ${username} = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.artur_passwd.path;
        extraGroups = [
          "wheel"
        ];
      };
    };
  };
}

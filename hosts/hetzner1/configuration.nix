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
      "hosts/hetzner1/hardware-configuration.nix"
      "modules/system/services/openssh.nix"
      "modules/system/maintenance.nix"
      "modules/system/nix.nix"
      "modules/system/grub.nix"
      "modules/core/default.nix"
    ])
  ];

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
    vim
    restic
  ];

  sops = {
    secrets = {
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
        openssh = {
          authorizedKeys = {
            keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGIjp6rpHPkO5g7z3x/JUdKs2gEHnBENX7bvhCabWi82 artur@desktop"
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII00qwteq//W0ea7/jEQWgQ32GiW9Nx66VoOSSYAJVOC artur@tuxedo"
            ];
          };
        };
      };
    };
  };
  security.sudo = {
    extraRules = [
      {
        groups = [ "wheel" ];
        commands = [
          {
            command = "/run/current-system/sw/bin/nix-store --no-gc-warning --realise /nix/store/*";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/nix-env --profile /nix/var/nix/profiles/system --set /nix/store/*";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/nix/store/*/bin/switch-to-configuration *";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}

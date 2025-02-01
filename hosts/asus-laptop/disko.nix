{ username, ... }:
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1000M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        # Workaround: cannot import 'zroot': I/O error in disko tests
        options.cachefile = "none";
        rootFsOptions = {
          compression = "zstd";
          acltype = "posixacl"; # Required for Podman, and can solve other issues with ZFS
          xattr = "sa"; # Store extended attributes directly in inode, improves performance
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          "com.sun:auto-snapshot" = "false";
        };
        postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot@blank$' || zfs snapshot zroot@blank";

        datasets = {
          root = {
            type = "zfs_fs";
            mountpoint = "/";
          };
          nix = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          home = {
            type = "zfs_fs";
            mountpoint = "/home";
          };
          "home/Documents" = {
            type = "zfs_fs";
            mountpoint = "/home/${username}/Documents";
          };
          "home//Downloads" = {
            type = "zfs_fs";
            mountpoint = "/home/${username}/Downloads";
          };
          "home/Desktop" = {
            type = "zfs_fs";
            mountpoint = "/home/${username}/Desktop";
          };
          "home/llms" = {
            type = "zfs_fs";
            mountpoint = "/home/${username}/llms";
          };
          podman = {
            type = "zfs_fs";
            mountpoint = "/var/lib/containers/storage";
          };
        };
      };
    };
  };
}

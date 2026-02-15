{ lib, ... }:
let
  commonNeomuttConfig = {
    enable = true;
    mailboxType = "maildir";
    extraConfig = ''
      set record='+Sent'
    '';
  };
in
{
  imports = [
    ./config.nix
    ./keybinds.nix
    ./macros.nix
  ];
  accounts = {
    email = {
      accounts = {
        migadu = {
          neomutt = lib.recursiveUpdate commonNeomuttConfig {
            extraConfig = ''
              mailboxes +Inbox +Drafts +Sent +Trash +Archive
            '';
          };
        };
        work = {
          neomutt = lib.recursiveUpdate commonNeomuttConfig {
            enable = true;
            extraConfig = ''
              mailboxes +Inbox +Drafts +Sent +Trash +Archives +"Junk Email"
              mailboxes +Slurm
            '';
          };
        };
      };
    };
  };

  programs = {
    neomutt = {
      enable = true;
      unmailboxes = true;
      vimKeys = false;
      editor = "nvim";
      sidebar = {
        enable = true;
        shortPath = true;
        format = "%B %* [%?N?%N / ?%S]";
      };
    };
  };
}

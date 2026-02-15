{ lib, ... }:
{
  programs = {
    neomutt = {
      enable = true;
      macros = [
        {
          key = "<f2>";
          map = [
            "index"
            "pager"
          ];
          action = "<sync-mailbox><refresh><enter-command>source ~/.config/neomutt/migadu<enter><change-folder>!<enter>";
        }
        {
          key = "<f3>";
          map = [
            "index"
            "pager"
          ];
          action = "<sync-mailbox><refresh><enter-command>source ~/.config/neomutt/work<enter><change-folder>!<enter>";
        }
        {
          key = "\\Cb";
          map = [
            "attach"
            "compose"
            "index"
            "pager"
          ];
          action = "<pipe-message> urlscan<Enter>";
        }
        {
          key = "S";
          map = [
            "index"
            "pager"
          ];
          # Sync email
          action = "<shell-escape>mbsync -V -a<enter><shell-escape>notmuch new<enter>";
        }
        {
          key = "\\\\";
          map = [
            "index"
            "pager"
          ];
          action = "<vfolder-from-query>";
        }
        {
          key = "A";
          map = [ "compose" ];
          action = lib.concatStrings [
            "<shell-escape>bash $HOME/.config/neomutt/filepicker<enter>"
            "<enter-command>source $HOME/.config/neomutt/tmpfile<enter>"
            "<shell-escape>bash $HOME/.config/neomutt/filepicker clean<enter>"
          ];
        }
        {
          key = "S";
          map = [ "attach" ];
          action = lib.concatStrings [
            "<shell-escape>bash $HOME/.config/neomutt/dirpicker<enter>"
            "<enter-command>source $HOME/.config/neomutt/tmpfile<enter>y<enter>"
          ];
        }
        # Sidebar macros
        {
          key = "\\Co";
          map = [
            "index"
            "pager"
          ];
          action = "<sidebar-toggle-visible>";
        }
        {
          key = "\\Cn";
          map = [
            "index"
            "pager"
          ];
          action = "<sidebar-next>";
        }
        {
          key = "\\Cp";
          map = [
            "index"
            "pager"
          ];
          action = "<sidebar-prev>";
        }
        {
          key = "\\CE";
          map = [
            "index"
            "pager"
          ];
          action = "<sidebar-open>";
        }
        {
          key = "A";
          map = [ "index" ];
          action = "<tag-pattern>~N<enter><tag-prefix><clear-flag>N<untag-pattern>.<enter>";
        }
        {
          key = "B";
          map = [
            "index"
            "pager"
          ];
          action = "<pipe-message>khard add-email<return> 'Add sender to address book'";
        }
        {
          key = "<Tab>";
          action = "<complete-query>";
          map = [ "editor" ];
        }
      ];
    };
  };
}

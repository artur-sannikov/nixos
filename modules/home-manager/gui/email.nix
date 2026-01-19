{
  pkgs,
  config,
  flake-inputs,
  lib,
  ...
}:
let
  utu_email = "${flake-inputs.nix-secrets.utu_email}";
  migadu_email = "${flake-inputs.nix-secrets.migadu_email}";
  mailcap_file = pkgs.writeText "mailcap" ''
    text/html; firefox %s; test=test -n "$display"; needsterminal
    text/html; lynx -assume_charset=%{charset} -display_charset=utf-8 -dump -width=1024 %s; nametemplate=%s.html; copiousoutput
    image/jpg; feh %s;
    image/jpg; feh %s;
    image/png; feh %s;
    image/svg; feh %s;
    image/gif; feh %s;
    application/vnd.openxmlformats-officedocument.presentationml.presentation; onlyoffice-desktopeditors %s;
    application/pdf; ${pkgs.kdePackages.okular}/bin/okular %s;
  '';
in
{
  sops = {
    secrets = {
      utu_password = { };
      migadu_password = { };
    };
  };

  # Write filepicker and dirpicker for neomutt
  home = {
    file = {
      ".config/neomutt/filepicker".source = ./filepicker;
      ".config/neomutt/dirpicker".source = ./dirpicker;
    };
  };

  # Email accounts
  accounts = {
    email = {
      accounts = {
        migadu = rec {
          primary = false;
          flavor = "migadu.com";
          address = migadu_email;
          userName = address;
          realName = "Artur Sannikov";
          passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.migadu_password.path}";
          imap = {
            host = "imap.migadu.com";
            port = 993;
            tls.enable = true;
          };
          smtp = {
            host = "smtp.migadu.com";
            port = 465;
          };
          neomutt = {
            enable = true;
            mailboxType = "maildir";
            extraConfig = ''
              unmailboxes *
              mailboxes +Inbox +Drafts +Sent +Trash +Archive
              set record='+Sent'
            '';
          };
          msmtp = {
            enable = true;
            # Setting the log is imperative to be able to send email...
            extraConfig = {
              logfile = "~/.cache/.msmtp_migadu.log";
            };
          };
          notmuch = {
            enable = true;
          };
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
            extraConfig.account = {
              PassCmd = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.migadu_password.path}";
              AuthMechs = "LOGIN";
              Host = "imap.migadu.com";
              TLSType = "IMAPS";
              Timeout = 60;
            };
          };
        };
        work = rec {
          primary = true;
          address = utu_email;
          userName = address;
          realName = "Artur Sannikov";
          signature = {
            text = ''
              Artur Sannikov
              Doctoral Researcher
              Food Sciences Unit, Department of Life Technologies
              University of Turku, Finland
            '';
            showSignature = "append";
          };
          passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.utu_password.path}";
          gpg = {
            key = "4653F089E0C1F62F4AB8FF09C76C0C265540AEF2";
            encryptByDefault = false;
            signByDefault = true;
          };
          imap = {
            host = "mail.utu.fi";
            port = 993;
            tls.enable = true;
          };
          smtp = {
            host = "mail.utu.fi";
            port = 587;
            tls = {
              useStartTls = true;
            };
          };
          thunderbird = {
            enable = true;
            profiles = [ "work" ];
            settings = id: {
              "mail.server.server_${id}.authMethod" = 3;
            };
          };
          neomutt = {
            enable = true;
            mailboxType = "maildir";
            extraConfig = ''
              unmailboxes *
              mailboxes +Inbox +Drafts +Sent +Trash +Archives +"Junk Email"
              mailboxes +Slurm
            '';
          };
          msmtp = {
            enable = true;
            extraConfig = {
              logfile = "~/.cache/.msmtp_work.log";
            };
          };
          notmuch = {
            enable = true;
          };
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
            extraConfig.account = {
              PassCmd = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.utu_password.path}";
              AuthMechs = "LOGIN";
              Host = "mail.utu.fi";
              TLSType = "IMAPS";
              Timeout = 60;
            };
          };
        };
      };
    };
  };

  # Enable email clients
  programs = {
    thunderbird = {
      enable = true;
      package = pkgs.thunderbird-latest;
      profiles = {
        work = {
          isDefault = true;
        };
      };
    };
    mbsync = {
      enable = true;
    };
    msmtp = {
      enable = true;
    };
    notmuch = {
      enable = true;
    };
    neomutt = {
      enable = true;
      vimKeys = false;
      editor = "nvim";
      sidebar = {
        enable = true;
        shortPath = true;
        format = "%B %* [%?N?%N / ?%S]";
      };
      binds = [
        {
          key = "\\CD";
          map = [
            "attach"
            "index"
            "pager"
          ];
          action = "next-page";
        }
        {
          key = "\\CU";
          map = [
            "attach"
            "index"
            "pager"
          ];
          action = "previous-page";
        }
        {
          key = "L"; # reply-all
          map = [
            "index"
            "pager"
          ];
          action = "group-reply";
        }
        {
          key = "g";
          map = [ "pager" ];
          action = "top";
        }
        {
          key = "G";
          map = [ "pager" ];
          action = "bottom";
        }
        {
          key = "g";
          map = [
            "attach"
            "index"
          ];
          action = "first-entry";
        }
        {
          key = "G";
          map = [
            "attach"
            "index"
          ];
          action = "last-entry";
        }
        # View attachments
        {
          key = "<return>";
          map = [ "attach" ];
          action = "view-mailcap";
        }
      ];
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
            "index"
            "pager"
          ];
          action = "<pipe-message> urlscan<Enter>";
        }
        {
          key = "\\Cb";
          map = [
            "attach"
            "compose"
          ];
          action = "<pipe-pipe-entry> urlscan<Enter>";
        }
        {
          key = "S";
          map = [ "index" ];
          # Sync email
          action = "<shell-escape>mbsync -V -a<enter><shell-escape>notmuch new<enter>";
        }
        {
          key = "\\\\";
          map = [ "index" ];
          action = "<vfolder-from-query>";
        }
        {
          key = "a";
          map = [ "compose" ];
          action = lib.concatStrings [
            "<shellescape>bash $HOME/.config/neomutt/filepicker<enter>"
            "<enter-command>source $HOME/.config/neomutt/tmpfile<enter>"
            "<shell-escape>bash $HOME/.config/neomutt/filepicker clean<enter>"
          ];
        }
        {
          key = "s";
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
      ];
      settings = {
        mailcap_path = "${mailcap_file}";
      };
      # Config reference: https://seniormars.com/posts/neomutt/
      extraConfig = ''
        # settings
        set pager_index_lines = 10
        set use_threads = yes                # threaded style in index
        set pager_context = 3                # show 3 lines of context
        set pager_stop = yes                 # stop at end of message
        set menu_scroll                      # scroll menu
        set tilde                            # use ~ to pad mutt
        set move = no                          # don't move messages when marking as read
        set mail_check = 30                  # check for new mail every 30 seconds
        set imap_keepalive = 900             # 15 minutes
        set sleep_time = 0                   # don't sleep when idle
        set wait_key = no		     # mutt won't ask "press key to continue"

        # Sending email
        set edit_headers                     # show headers when composing
        set include                          # include message in replies
        set fast_reply                       # skip to compose when replying
        set askcc                            # ask for CC:
        set reverse_name                     # reply as whomever it was to
        set reply_to                         # reply to Reply to: field

        set fcc_attach                       # save attachments with the body
        set forward_format = "Fwd: %s"       # format of subject when forwarding
        set forward_decode                   # decode when forwarding
        set forward_quote                    # include message in forwards
        set mime_forward                     # forward attachments as part of body
        set attribution = "On %d, %n wrote:" # format of quoting header
        set text_flowed=yes                  # correct indentation for plain text

        set mbox_type = Maildir
        # set postponed = "+Drafts"
        # set record = "+Sent"
        # set trash = "+Trash"

        # Caching
        set header_cache     = ~/.cache/neomutt/cache/  # where to store headers
        set message_cachedir = ~/.cache/neomutt/cache/  # where to store bodies

        unset sig_dashes                     # no dashes before sig
        unset markers

        # Sort by newest conversation first.
        set charset = "utf-8"
        set uncollapse_jump
        set sort_re
        set sort = reverse-threads
        set sort_aux = last-date-received

        # How we reply and quote emails.
        set reply_regexp = "^(([Rr][Ee]?(\[[0-9]+\])?: *)?(\[[^]]+\] *)?)*"
        set quote_regexp = "^( {0,4}[>|:#%]| {0,4}[a-z0-9]+[>|]+)+"
        set send_charset = "utf-8:iso-8859-1:us-ascii" # send in utf-8

        ### Encryption ###

        # Use GPGME
        set crypt_use_gpgme = yes

        # Automatically sign all outgoing email
        set crypt_auto_sign = yes

        # Sign replies to signed emails
        set crypt_reply_sign = yes

        # Encrypt replies to encrypted emails
        set crypt_reply_encrypt = yes

        # Encrypt and sign replies to encrypted and signed email
        set crypt_reply_sign_encrypted = yes

        # Attempt to verify signatures automatically
        set crypt_verify_sig = yes

        # Do not attempt to encrypt automatically
        set crypt_opportunistic_encrypt = no

        # Auto-view encrypted emails automatically
        auto_view application/pgp-encrypted

        # sidebar
        set sidebar_folder_indent
        set mail_check_stats
        set sidebar_width = 15                        # width in screen columns

        # See https://seniormars.com/posts/neomutt/
        # Default index colors:
        color index yellow default '.*'
        color index_author green default '.*'
        color index_number blue default
        color index_subject white default '.*'

        # For new mail:
        color index brightyellow black "~N"
        color index_author brightgreen black "~N"
        color index_subject brightwhite black "~N"

        # Header colors:
        color header blue default ".*"
        color header brightmagenta default "^(From)"
        color header brightwhite default "^(Subject)"
        color header brightcyan default "^(CC|BCC)"

        mono bold bold
        mono underline underline
        mono indicator reverse
        mono error bold
        color normal default default
        color indicator brightblack white
        color sidebar_highlight red default
        color sidebar_divider brightblack black
        color sidebar_flagged red black
        color sidebar_new green black
        color normal brightyellow default
        color error red default
        color tilde black default
        color message cyan default
        color markers red white
        color attachment white default
        color search brightmagenta default
        color status brightyellow black
        color hdrdefault brightgreen default
        color quoted green default
        color quoted1 blue default
        color quoted2 cyan default
        color quoted3 yellow default
        color quoted4 red default
        color quoted5 brightred default
        color signature brightgreen default
        color bold black default
        color underline black default
        color normal default default

        color body brightcyan default "[\-\.+_a-zA-Z0-9]+@[\-\.a-zA-Z0-9]+" # Email addresses
        color body brightblue default "(https?|ftp)://[\-\.,/%~_:?&=\#a-zA-Z0-9]+" # URL
        color body green default "\`[^\`]*\`" # Green text between ` and `
        color body brightblue default "^# \.*" # Headings as bold blue
        color body brightcyan default "^## \.*" # Subheadings as bold cyan
        color body brightgreen default "^### \.*" # Subsubheadings as bold green
        color body yellow default "^(\t| )*(-|\\*) \.*" # List items as yellow
        color body brightcyan default "[;:][-o][)/(|]" # emoticons
        color body brightcyan default "[;:][)(|]" # emoticons
        color body brightcyan default "[ ][*][^*]*[*][ ]?" # more emoticon?
        color body brightcyan default "[ ]?[*][^*]*[*][ ]" # more emoticon?
        color body red default "(BAD signature)"
        color body cyan default "(Good signature)"
        color body brightblack default "^gpg: Good signature .*"
        color body brightyellow default "^gpg: "
        color body brightyellow red "^gpg: BAD signature from.*"
        mono body bold "^gpg: Good signature"
        mono body bold "^gpg: BAD signature from.*"
        color body red default "([a-z][a-z0-9+-]*://(((([a-z0-9_.!~*'();:&=+$,-]|%[0-9a-f][0-9a-f])*@)?((([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?|[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)(:[0-9]+)?)|([a-z0-9_.!~*'()$,;:@&=+-]|%[0-9a-f][0-9a-f])+)(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?(#([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?|(www|ftp)\\.(([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?(:[0-9]+)?(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?(#([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?)[^].,:;!)? \t\r\n<>\"]"
      '';
    };
  };
  # Contacts
  programs.abook = {
    enable = true;
  };
}

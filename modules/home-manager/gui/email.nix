{
  pkgs,
  config,
  flake-inputs,
  ...
}:
let
  utu_email = "${flake-inputs.nix-secrets.utu_email}";
  mailcap_file = pkgs.writeText "mailcap" ''
    text/html; firefox %s; test=test -n "$display"; needsterminal
    text/html; lynx -assume_charset=%{charset} -display_charset=utf-8 -dump -width=1024 %s; nametemplate=%s.html; copiousoutput
    text/plain; cat %s; copiousoutput
    application/pdf; ${pkgs.kdePackages.okular}/bin/okular %s;
  '';
in
{
  sops = {
    secrets = {
      utu_password = { };
    };
  };

  # Email accounts
  accounts = {
    email = {
      accounts = {
        work = rec {
          primary = true;
          address = utu_email;
          userName = address;
          realName = "Artur Sannikov";
          passwordCommand = " ${pkgs.coreutils}/bin/cat ${config.sops.secrets.utu_password.path}";
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
            mailboxType = "imap";
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
          map = "attach";
          action = "view-mailcap";
        }
      ];
      macros = [
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
      ];
      settings = {
        mailcap_path = "${mailcap_file}";
      };
      # Config reference: https://seniormars.com/posts/neomutt/
      extraConfig = ''
        # settings
        set pager_index_lines = 10          
        set pager_context = 3                # show 3 lines of context
        set pager_stop                       # stop at end of message
        set menu_scroll                      # scroll menu
        set tilde                            # use ~ to pad mutt
        set move = no                          # don't move messages when marking as read
        set mail_check = 30                  # check for new mail every 30 seconds
        set imap_keepalive = 900             # 15 minutes
        set sleep_time = 0                   # don't sleep when idle
        set wait_key = no		     # mutt won't ask "press key to continue"
        set envelope_from                    # which from?
        set edit_headers                     # show headers when composing
        set fast_reply                       # skip to compose when replying
        set askcc                            # ask for CC:
        set fcc_attach                       # save attachments with the body
        set forward_format = "Fwd: %s"       # format of subject when forwarding
        set forward_decode                   # decode when forwarding
        set forward_quote                    # include message in forwards
        set mime_forward                     # forward attachments as part of body
        set attribution = "On %d, %n wrote:" # format of quoting header
        set reply_to                         # reply to Reply to: field
        set reverse_name                     # reply as whomever it was to
        set include                          # include message in replies
        set text_flowed=yes                  # correct indentation for plain text
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

        #sidebar
        set sidebar_folder_indent
        set mail_check_stats
        bind index,pager \CJ sidebar-prev
        bind index,pager \CK sidebar-next
        bind index,pager \CE sidebar-open
        bind index,pager B sidebar-toggle-visible

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

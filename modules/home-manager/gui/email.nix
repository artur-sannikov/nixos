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
      '';
    };
  };
}

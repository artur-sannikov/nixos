{
  flake.modules.homeManager.email =
    { pkgs, ... }:
    let
      mailcap_file = pkgs.writeText "mailcap" ''
        text/html; firefox %s; test=test -n "$display"; needsterminal
        text/plain; $EDITOR %s ;needsterminal
        text/csv; tw %s ; needsterminal
        image/*; feh %s;
        application/vnd.openxmlformats-officedocument.presentationml.presentation; onlyoffice-desktopeditors %s;
        application/pdf; ${pkgs.kdePackages.okular}/bin/okular %s;
        text/html; elinks -dump %s; copiousoutput
      '';
    in
    {
      home = {
        file = {
          ".config/neomutt/filepicker".source = ./filepicker;
          ".config/neomutt/dirpicker".source = ./dirpicker;
        };
      };
      programs = {
        neomutt = {
          settings = {
            mailcap_path = "${mailcap_file}";
            query_command = ''"${pkgs.khard}/bin/khard email --parsable %s"'';
            pager_index_lines = "10"; # threaded style in index
            sidebar_width = "15";
          };
          extraConfig = ''
            # settings
            set use_threads = yes
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
            auto_view application/pgp-encrypted text/html
            alternative_order text/plain text/html

            # sidebar
            set sidebar_folder_indent
            set mail_check_stats

            ### Color scheme ###

            # https://github.com/catppuccin/neomutt/blob/main/neomuttrc
            # Catppuccin Mocha (Modified)
            color normal		  default default         # Text is "Text"
            color index		    color2 default ~N       # New Messages are Green
            color index		    color1 default ~F       # Flagged messages are Red
            color index		    color13 default ~T      # Tagged Messages are Red
            color index		    color1 default ~D       # Messages to delete are Red
            color attachment	color5 default          # Attachments are Pink
            color signature	  color8 default          # Signatures are Surface 2
            color search		  color4 default          # Highlighted results are Blue

            color indicator		default color8          # currently highlighted message Surface 2=Background Text=Foreground
            color error		    color1 default          # error messages are Red
            color status		  color15 default         # status line "Subtext 0"
            color tree        color15 default         # thread tree arrows Subtext 0
            color tilde       color15 default         # blank line padding Subtext 0

            # Header colors:
            color header		  color13 default "^Date:" # Pink
            color header		  color1 default "^From:" # Red
            color header		  color13 default "^To:" # Pink
            color header	 	  color14 default "^Subject:" # Bright Teal
            color header      color15 default "^(CC|BCC)" # White

            color quoted		  color15 default         # Subtext 0
            color quoted1		  color7 default          # Subtext 1
            color quoted2		  color8 default          # Surface 2
            color quoted3		  color0 default          # Surface 1
            color quoted4		  color0 default
            color quoted5		  color0 default

            color body		color2 default		[\-\.+_a-zA-Z0-9]+@[\-\.a-zA-Z0-9]+               # email addresses Green
            color body	  color2 default		(https?|ftp)://[\-\.,/%~_:?&=\#a-zA-Z0-9]+        # URLs Green
            color body		color4 default		(^|[[:space:]])\\*[^[:space:]]+\\*([[:space:]]|$) # *bold* text Blue
            color body		color4 default		(^|[[:space:]])_[^[:space:]]+_([[:space:]]|$)     # _underlined_ text Blue
            color body		color4 default		(^|[[:space:]])/[^[:space:]]+/([[:space:]]|$)     # /italic/ text Blue

            color sidebar_flagged   color1 default    # Mailboxes with flagged mails are Red
            color sidebar_new       color10 default   # Mailboxes with new mail are Green

            # Other aesthetics
            # Taken from https://seniormars.com/posts/neomutt/
            # https://github.com/SeniorMars/dotfiles/blob/main/.config/mutt/colors.muttrc
            mono bold bold
            mono underline underline
            mono indicator reverse
            mono error bold
            mono body bold "^gpg: Good signature"
            mono body bold "^gpg: BAD signature from.*"
          '';
        };
      };
    };
}

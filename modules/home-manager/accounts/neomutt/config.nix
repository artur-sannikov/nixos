{ pkgs, ... }:
let
  mailcap_file = pkgs.writeText "mailcap" ''
    text/html; firefox %s; test=test -n "$display"; needsterminal
    text/html; lynx -assume_charset=%{charset} -display_charset=utf-8 -dump -width=1024 %s; nametemplate=%s.html; copiousoutput
    text/plain; $EDITOR %s ; needsterminal
    image/*; feh %s;
    application/vnd.openxmlformats-officedocument.presentationml.presentation; onlyoffice-desktopeditors %s;
    application/pdf; ${pkgs.kdePackages.okular}/bin/okular %s;
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
}

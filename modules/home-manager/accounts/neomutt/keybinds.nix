{
  programs = {
    neomutt = {

      binds = [
        {
          key = "\\CD";
          map = [
            "index"
            "pager"
          ];
          action = "half-down";
        }
        {
          key = "\\CU";
          map = [
            "index"
            "pager"
          ];
          action = "half-up";
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
          key = "D";
          map = [
            "index"
            "pager"
          ];
          action = "purge-message";
        }
        {
          key = "g";
          map = [
            "attach"
            "index"
            "pager"
          ];
          action = "noop";
        }
        {
          key = "gg";
          map = [
            "pager"
          ];
          action = "top";
        }
        {
          key = "G";
          map = [ "pager" ];
          action = "bottom";
        }
        {
          key = "gg";
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
        {
          key = "<space>";
          map = [
            "index"
          ];
          action = "collapse-thread";
        }
        # View attachments
        {
          key = "<return>";
          map = [ "attach" ];
          action = "view-mailcap";
        }
      ];
    };
  };
}

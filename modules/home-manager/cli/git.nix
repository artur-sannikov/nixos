{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      userName = "Artur Sannikov";
      userEmail = "40318410+artur-sannikov@users.noreply.github.com";
      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        merge.conflictstyle = "zdiff3";
        credential.helper = "cache";
        diff = {
          algorithm = "histogram";
          colorMoved = "default";
        };
        url = {
          "git@github.com:" = {
            insteadOf = "https://github.com/";
          };
        };
        user.signingKey = "/home/artur/.ssh/git-sign.pub";
        commit.gpgsign = "true";
        gpg.format = "ssh";
      };
      ignores = [
        ".DS_Store"
        ".direnv/"
        ".envrc"
        "result"
      ];
    };
  };
  home.packages = with pkgs; [
    # Rewrite git history
    git-filter-repo
  ];
}

{ pkgs, username, ... }:
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
        commit.gpgsign = "true";
        gpg.format = "ssh";
        user.signingkey = "/home/${username}/.ssh/git-sign.pub";
        gpg.ssh.allowedSignersFile = "/home/${username}/.ssh/allowed_signers";
      };
      ignores = [
        ".DS_Store"
        ".direnv/"
        ".devcontainer/"
        ".envrc"
        "result"
      ];
      lfs = {
        enable = true;
      };
    };
    gh = {
      enable = true;
    };
  };
  home.packages = with pkgs; [
    # Rewrite git history
    git-filter-repo
  ];
}

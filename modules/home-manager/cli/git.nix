{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "Artur Sannikov";
          email = "git-sign@asannikov.com";
          signingkey = "AF9397CF9FF360BC";
        };
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        merge = {
          conflictstyle = "zdiff3";
          tool = "nvim";
        };
        mergetool = {
          promt = false;
          "nvim" = {
            cmd = "nvim -d \"$BASE\" \"$LOCAL\" \"$REMOTE\" \"$MERGED\" -c 'wincmd w' 'wincmd J' -c 'norm ]c'";
          };
        };
        credential.helper = "cache";
        diff = {
          algorithm = "histogram";
          colorMoved = "default";
        };
        commit.gpgsign = true;
      };
      ignores = [
        ".Rproj.user"
        ".Rhistory"
        ".RData"
        ".RDataTmp"
        ".Renviron"
        ".quarto"
        ".DS_Store"
        ".direnv/"
        ".devcontainer/"
        "result"
      ];
      lfs = {
        enable = true;
      };
    };
    gh = {
      enable = true;
      extensions = with pkgs; [ gh-s ];
      settings = {
        git_protocol = "https";
        prompt = "enabled";
        editor = "nvim";
      };
    };
  };
  home.packages = with pkgs; [
    # Rewrite git history
    git-filter-repo
  ];
}

{
  imports = [
    (
      fetchGit {
        url = "https://github.com/anthonyroussel/shadow-nix";
        rev = "caae642e4ac8051fa7b751e78492ebd22e7b2153";
        ref = "refs/tags/v1.5.0";
      }
      + "/import/system.nix"
    )
  ];
  programs.shadow-client = {
    channel = "prod";
  };
}

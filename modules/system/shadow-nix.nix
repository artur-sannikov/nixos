{ flake-inputs, ... }:

{
  # imports = [
  #   (
  #     fetchGit {
  #       url = "https://github.com/cornerman/shadow-nix";
  #       ref = "refs/tags/v2.0.2";
  #       rev = "426affb76b29d872447ff1fdb34728023e475535";
  #     }
  #     + "/import/system.nix"
  #   )
  # ];
  imports = [ (flake-inputs.shadow-nix + "/import/system.nix") ];

  programs.shadow-client = {
    # Enabled by default when using import
    # enable = true;
    channel = "prod";
  };
}

# {
#   imports = [
#     (
#       fetchGit {
#         url = "https://github.com/anthonyroussel/shadow-nix";
#         rev = "caae642e4ac8051fa7b751e78492ebd22e7b2153";
#         ref = "refs/tags/v1.5.0";
#       }
#       + "/import/system.nix"
#     )
#   ];
#   programs.shadow-client = {
#     channel = "prod";
#   };
# }

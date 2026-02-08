# Set current hostname
hostname := `hostname`

# Aliases
alias t := test
alias s := switch

# Default command when 'just' is run without arguments
default:
  @just --list

up:
  nix flake update

upp input:
  nix flake update {{input}}

test:
    echo "Testing configuration for {{hostname}}"
    sudo nixos-rebuild test --flake .#{{hostname}}

switch:
    echo "Switching configuration for {{hostname}}"
    sudo nixos-rebuild switch --flake .#{{hostname}}

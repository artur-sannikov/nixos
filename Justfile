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

deploy host:
    #!/usr/bin/env bash
    if [ "{{host}}" = "homelab-nixos" ]; then
        ssh -t pve2 'qm delsnapshot 105 update; qm snapshot 105 update'
        nix run github:serokell/deploy-rs .#{{host}}
    else
        nix run github:serokell/deploy-rs .#{{host}}
    fi

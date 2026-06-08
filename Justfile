# Set current hostname

hostname := `hostname`

# Aliases

alias t := test
alias s := switch
alias b := boot

# Default command when 'just' is run without arguments
default:
    @just --list

up:
    nix flake update

upp input:
    nix flake update {{ input }}

test:
    echo "Testing configuration for {{ hostname }}"
    sudo nixos-rebuild test --flake .#{{ hostname }}

switch:
    echo "Switching configuration for {{ hostname }}"
    sudo nixos-rebuild switch --flake .#{{ hostname }}

boot:
    echo "Creating boot entry for {{ hostname }}"
    sudo nixos-rebuild boot --flake .#{{ hostname }}

build host:
    echo "Building configuration for {{ host }}"
    nix build .#nixosConfigurations.{{ host }}.config.system.build.toplevel

lint:
    statix check --ignore hardware-configuration.nix .

deploy host:
    #!/usr/bin/env bash
    if [ "{{ host }}" = "homelab-nixos" ]; then
        ssh -t pve2 'qm snapshot 108 update_$(date -d "today" +"%Y%m%d%H%M")'
        nix run github:serokell/deploy-rs .#{{ host }}
    else
        nix run github:serokell/deploy-rs .#{{ host }}
    fi

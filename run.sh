#!/bin/bash

set -e # fail on error
set -o pipefail # fail on pipefail
set -u # fail on unset variables
# set -x # echo on

action=${1:-build}
host_arch=$(uname -m)
host_os=$(uname -s)

unsupported_system() {
    echo "Unsupported system: $host_arch-$host_os"
    exit 1
}

darwin() {
    if [ "$action" = "install" ]; then
        nix run nix-darwin -- switch --flake .#tom-m1
    else
        darwin-rebuild switch --flake .#tom-m1
    fi
}

linux() {
    if [ "$action" = "install" ]; then
        nix run home-manager -- switch --flake .#tom-vm
    else
        home-manager switch --flake .#tom-vm
    fi
}

main() {
    case "$host_arch-$host_os" in
        "arm64-Darwin")
            darwin "$action"
            ;;
        "x86_64-Linux")
            linux "$action"
            ;;
        *)
            unsupported_system
            ;;
    esac
}

main && exit 0

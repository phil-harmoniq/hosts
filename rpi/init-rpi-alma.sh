#!/usr/bin/env bash

set -euo pipefail
script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
base_url=""

main()
{
    add_shell_config
    install_packages
    enable_cockpit
}

add_shell_config()
{
    SOURCE_BASH_CONFIG_DIR="$script_dir/.bashrc.d"
    DEST_BASH_CONFIG_DIR="$HOME/.bashrc.d/"

    mkdir -p "$DEST_BASH_CONFIG_DIR"
    cp "$SOURCE_BASH_CONFIG_DIR/aliases" "$DEST_BASH_CONFIG_DIR"
    cp "$SOURCE_BASH_CONFIG_DIR/prompt" "$DEST_BASH_CONFIG_DIR"
    cp "$script_dir/.inputrc" "$HOME"
}

install_packages()
{
    dnf install epel-release
    dnf install podman git btop tldr shellcheck fastfetch
}

enable_cockpit()
{
    systemctl enable cockpit
    systemctl start cockpit
}

main

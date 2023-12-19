#!/bin/bash

# shellcheck source=/dev/null

declare current_dir && \
    current_dir="$(dirname "${BASH_SOURCE[0]}")" && \
    cd "${current_dir}" && \
    source "$HOME/set-me-up/.dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_pip_packages() {

    # Check that pip3 and pipx are installed

    if ! cmd_exists "pip3"; then
        print_error "pip3 is not installed"
        exit 1
    fi

    if ! cmd_exists "pipx"; then
        print_error "pipx is not installed"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install pip packages

    pipx install \
        # trash-cli trashes files recording the original path, deletion date, and permissions. 
        # It uses the same trashcan used by KDE, GNOME, and XFCE, but you can invoke it from 
        # the command line (and scripts).
        # https://github.com/andreafrancia/trash-cli
        trash-cli \
        'trash-cli[completion]'  \
        # Performance monitoring CLI tool for Apple Silicon
        # see: https://github.com/tlkh/asitop
        asitop
}

configure_trash_cli() {

    # Create a directory for the trash-cli
    # see: https://github.com/andreafrancia/trash-cli#how-to-create-a-top-level-trash-dir

    sudo mkdir --parent /.Trash
    sudo chmod a+rw /.Trash
    sudo chmod +t /.Trash

}

main() {

    brew_bundle_install -f "brewfile"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_pip_packages

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    configure_trash_cli

}

main
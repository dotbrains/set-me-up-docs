#!/bin/bash

# shellcheck source=/dev/null

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" &&
    source "$HOME/set-me-up/.dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    brew_bundle_install -f "brewfile"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Start 'yabai' and 'skhd' on login
    # This will require accessibility permissions to be granted to both apps
    # see: https://github.com/koekeishiya/yabai
    # see: https://github.com/koekeishiya/skhd

    yabai --install-service
    yabai --start-service

    skhd --install-service
    skhd --start-service

}

main

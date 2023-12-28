#!/bin/bash

# shellcheck source=/dev/null

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" &&
    source "$HOME/set-me-up/.dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    install_from_URL "https://updates.topnotch.app/TopNotch-latest.zip"
    install_from_URL "https://www.withmarko.com/s/OneMenu260.zip"

}

main

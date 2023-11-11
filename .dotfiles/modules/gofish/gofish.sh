#!/bin/bash

# shellcheck source=/dev/null

declare current_dir && \
    current_dir="$(dirname "${BASH_SOURCE[0]}")" && \
    cd "${current_dir}" && \
    source "$HOME/set-me-up/.dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_gofish() {
    if ! brew install gofish; then
        echo "Installation of gofish failed."
        return 1
    fi

    gofish init

}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

	if ! cmd_exists "gofish"; then
        if ! install_gofish; then
            return 1
        fi
    fi

	gofish_update

	gofish_upgrade

	gofish_cleanup

}

main

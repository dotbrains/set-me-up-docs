#!/bin/bash

# shellcheck source=/dev/null

declare current_dir && \
    current_dir="$(dirname "${BASH_SOURCE[0]}")" && \
    cd "${current_dir}" && \
    source "$HOME/set-me-up/.dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_gofish() {

	brew install gofish && {
		gofish init
	}

}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

	if ! cmd_exists "gofish"; then
        install_gofish
    fi

	gofish_update

	gofish_upgrade

	gofish_cleanup

}

main

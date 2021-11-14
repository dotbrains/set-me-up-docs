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

upgrade_gofish() {

	gofish_update

	gofish_upgrade

	gofish_cleanup

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

	if ! cmd_exists "gofish"; then
        install_gofish
    else
		upgrade_gofish
	fi

}

main

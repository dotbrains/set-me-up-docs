#!/bin/bash

# shellcheck source=/dev/null

declare current_dir && \
    current_dir="$(dirname "${BASH_SOURCE[0]}")" && \
    cd "${current_dir}" && \
    source "$HOME/set-me-up/.dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

	install_dmg_from_URL "https://download.airbuddy.app/WebDownload/ed9e9b7a-103b-4315-a411-ff4ab21f5f8b/AirBuddy2.dmg"
	install_dmg_from_URL "https://updates.topnotch.app/TopNotch-latest.zip"

}

main

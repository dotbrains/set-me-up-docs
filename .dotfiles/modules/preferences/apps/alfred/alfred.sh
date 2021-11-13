#!/bin/bash

source "$HOME/set-me-up/.dotfiles/utilities/utilities.sh"

if brew info alfred &>/dev/null; then
	# install alfred packages
	npx_install "awm"

	[[ -f "$(locate_alfred_preferences)" ]] && {
		npx_install "alfred-fkill"
		npx_install "@bchatard/alfred-jetbrains"
		npx_install "alfred-npms"
	}
fi

#!/bin/bash

if brew info alfred &>/dev/null; then
	# install alfred packages
	npx_install "awm"

	[[ -f "$(locate_alfred_preferences)" ]] && {
		npx_install "alfred-fkill"
		npx_install "@bchatard/alfred-jetbrains"
		npx_install "alfred-npms"
	}
fi

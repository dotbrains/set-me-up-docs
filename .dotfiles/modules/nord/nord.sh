#!/bin/bash

# shellcheck source=/dev/null

declare current_dir && \
    current_dir="$(dirname "${BASH_SOURCE[0]}")" && \
    cd "${current_dir}" && \
    source "$HOME/set-me-up/.dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    brew_bundle_install -f "brewfile"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    fish -c "fish_config theme save \"Nord\""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Nord for terminal on MacOS

    ./apps/terminal/set_terminal_theme.applescript

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Nord for iTerm2

    # install nord iterm2 color preset
    # open "${PWD}/iterm2/nord.itermcolors"

    # set nord color preset
    # defaults write com.googlecode.iterm2 "Custom Color Presets" -dict-add "Nord" "$(cat "${PWD}/iterm2/nord.itermcolors")"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Set the desktop background to the Nord wallpaper

    # Check if the `wallpaper` command exists
    if cmd_exists "wallpaper"; then
        wallpaper set "${PWD}/wallpapers/magma.jpg"
    fi

}

main
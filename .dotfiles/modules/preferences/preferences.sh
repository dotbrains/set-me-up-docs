#!/bin/bash

# shellcheck source=/dev/null

# Mac OS configuration
#
# This configuration applies to the latest version of macOS (currently 12.0.1),
# and sets up preferences and configurations for all the built-in services and
# apps. Third-party app config should be done elsewhere.
#
# If you want to figure out what default needs changing, do the following:
#
#   1. `cd /tmp`
#   2. Store current defaults in file: `defaults read > before`
#   3. Make a change to your system.
#   4. Store new defaults in file: `defaults read > after`
#   5. Diff the files: `diff before after`
#
# @see: http://secrets.blacktree.com/?showapp=com.apple.finder
# @see: https://github.com/herrbischoff/awesome-macos-command-line
#
# @author Nicholas Adamou

declare current_dir && \
    current_dir="$(dirname "${BASH_SOURCE[0]}")" && \
    cd "${current_dir}" && \
    source "$HOME/set-me-up/.dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    brew_bundle_install "brewfile"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Close any open `System Preferences` panes in order to
    # avoid overriding the preferences that are being changed.

    ./close_system_preferences_panes.applescript

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # App preferences
    ./apps/terminal/terminal.sh
	./apps/iTerm2/iterm2.sh
    ./apps/app_store.sh
    ./apps/finder.sh
	./apps/activity_monitor.sh
	./apps/messages.sh
	./apps/mail.sh
    ./apps/chrome.sh
    ./apps/safari.sh
    ./apps/maps.sh
    ./apps/photos.sh
    ./apps/transmission.sh
    ./apps/textedit.sh
    ./apps/firefox.sh
    ./apps/alfred/alfred.sh

    # System preferences
	./system/screen.sh
	./system/spotlight.sh
    ./system/dashboard.sh
    ./system/dock.sh
    ./system/keyboard.sh
	./system.trackpad.sh
    ./system/language_and_region.sh
    ./system/ui_and_ux.sh
	./system/launchpad.sh

}

main

#!/bin/bash

# shellcheck source=/dev/null

declare current_dir && \
    current_dir="$(dirname "${BASH_SOURCE[0]}")" && \
    cd "${current_dir}" && \
    source "$HOME/set-me-up/.dotfiles/utilities/utils.sh"
    
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Chrome\n\n"

execute "defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool true" \
    "Enable backswipe"

execute "defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true" \
    "Expand print dialog by default"

execute "defaults write com.google.Chrome DisablePrintPreview -bool true" \
    "Use system-native print preview dialog"

killall "Google Chrome" &> /dev/null
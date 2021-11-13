#!/bin/bash

# Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 30

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.15

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Enable the 'reduce transparency' option. Save GPU cycles.
defaults write com.apple.universalaccess reduceTransparency -bool true

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

# Bottom right screen corner → Mission Control
#defaults write com.apple.dock wvous-br-corner -int 2
#defaults write com.apple.dock wvous-br-modifier -int 0

# Top right screen corner → Put display to sleep
# defaults write com.apple.dock wvous-tr-corner -int 10
# defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left screen corner → Desktop
# defaults write com.apple.dock wvous-bl-corner -int 4
# defaults write com.apple.dock wvous-bl-modifier -int 0

killall "Dock" &> /dev/null

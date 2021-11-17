#!/bin/zsh

defaults write org.mozilla.firefox AppleEnableSwipeNavigateWithScrolls -bool false

killall "firefox" &> /dev/null

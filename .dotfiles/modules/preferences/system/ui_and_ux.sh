#!/bin/bash

declare -r DESKTOP_WALLPAPER_PATH="${PWD}/system/wallpapers/magma.jpg"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if brew info wallpaper &>/dev/null; then
	wallpaper set "$DESKTOP_WALLPAPER_PATH"
fi

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Change the Mac's host name
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string 'macOS' && \
		sudo scutil --set ComputerName 'macOS' && \
		sudo scutil --set HostName 'macOS' && \
		sudo scutil --set LocalHostName 'macOS'

sudo systemsetup -setrestartfreeze on

for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
            sudo defaults write "${domain}" dontAutoLoad -array \
                '/System/Library/CoreServices/Menu Extras/TimeMachine.menu' \
                '/System/Library/CoreServices/Menu Extras/Volume.menu'
		done \
            && sudo defaults write com.apple.systemuiserver menuExtras -array \
                '/System/Library/CoreServices/Menu Extras/Bluetooth.menu' \
                '/System/Library/CoreServices/Menu Extras/AirPort.menu' \
                '/System/Library/CoreServices/Menu Extras/Battery.menu' \
                '/System/Library/CoreServices/Menu Extras/Clock.menu'

killall "SystemUIServer" &> /dev/null

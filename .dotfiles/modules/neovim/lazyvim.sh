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

    # Check if git is installed
    if ! cmd_exists "git"; then
        print_error "Git is required, please install it!\n"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # LazyVim

    # Check if ~/.config/nvim exists
    if [ -d "$HOME/.config/nvim" ]; then
        mv "$HOME/.config/nvim" "$HOME/.config/lazyvim.backup"
    fi

    git clone https://github.com/LazyVim/starter ~/.config/nvim

    # Check if ~/.config/nvim exists
    if [ ! -d "$HOME/.config/nvim" ]; then
        print_error "~/.config/nvim does not exist!\n"
        exit 1
    fi

    # Remove the .git folder, so it doesn't interfere with the dotfiles git repo
    rm -rf ~/.config/nvim/.git

    # Create colorscheme.lua if it doesn't exist
    # Set colorscheme to nord

    local colorscheme_file="$HOME/.config/nvim/lua/plugins/colorscheme.lua"
    
    if [ ! -f "$colorscheme_file" ]; then
        mkdir -nvimp "$HOME/.config/nvim/lua/plugins"
        touch "$colorscheme_file"
    fi

    # Append lines to colorscheme.lua
    echo 'return {
    { "shaunsingh/nord.nvim" },

    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "nord",
        },
    },
}' >> "$colorscheme_file"

}

main

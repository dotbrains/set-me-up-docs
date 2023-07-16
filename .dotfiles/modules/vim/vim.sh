#!/bin/bash

# shellcheck source=/dev/null

declare current_dir && \
    current_dir="$(dirname "${BASH_SOURCE[0]}")" && \
    cd "${current_dir}" && \
    source "$HOME/set-me-up/.dotfiles/utilities/utilities.sh"

declare -r VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"
declare -r VUNDLE_GIT_REPO_URL="https://github.com/VundleVim/Vundle.vim.git"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_vimrc_local() {

    declare -r FILE_PATH="$HOME/.vimrc.local"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [[ ! -e "$FILE_PATH" ]] || [[ -z "$FILE_PATH" ]]; then
        touch "$FILE_PATH"
    fi

}

install_plugins() {

    # Make sure 'backups', 'swaps' & 'undos' directories exist.
    # If not, create them.

    [[ ! -d "$HOME/.vim/backups" ]] && \
        mkdir -p "$HOME/.vim/backups"

    [[ ! -d "$HOME/.vim/swaps" ]] && \
        mkdir -p "$HOME/.vim/swaps"

    [[ ! -d "$HOME/.vim/undos" ]] && \
        mkdir -p "$HOME/.vim/undos"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install plugins.

    git clone --quiet "$VUNDLE_GIT_REPO_URL" "$VUNDLE_DIR" \
            && printf '\n' | vim +PluginInstall +qall \
        || return 1

}

update_plugins() {

    vim +PluginUpdate +qall

}

install_space_vim() {

	curl -sLf https://spacevim.org/install.sh | bash

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    brew_bundle_install -f "brewfile"

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	create_vimrc_local

	if [[ ! -d "$VUNDLE_DIR" ]]; then
        install_plugins
    else
        update_plugins
    fi

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	install_space_vim

}

main

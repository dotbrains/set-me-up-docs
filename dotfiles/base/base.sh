#!/bin/bash

# shellcheck source=/dev/null

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" &&
    source "$HOME/set-me-up/dotfiles/utilities/utilities.sh"

readonly SMU_PATH="$HOME/set-me-up"

# Get the absolute path of the dotfiles directory.
# This is only for aesthetic reasons to have an absolute symlink path instead of a relative one
# <path-to-smu>/dotfiles/somedotfile vs <path-to-smu>/dotfiles/base/../somedotfile
readonly dotfiles="${SMU_PATH}/dotfiles"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_homebrew() {

    printf "\n" |
        /bin/bash -c \
            "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

}

get_homebrew_git_config_file_path() {

    local path=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if path="$(brew --repository 2>/dev/null)/.git/config"; then
        printf "%s" "$path"
        return 0
    else
        return 1
    fi

}

opt_out_of_analytics() {

    local path=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Try to get the path of the `Homebrew` git config file.

    path="$(get_homebrew_git_config_file_path)" ||
        return 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Opt-out of Homebrew's analytics.
    # https://github.com/Homebrew/brew/blob/0c95c60511cc4d85d28f66b58d51d85f8186d941/share/doc/homebrew/Analytics.md#opting-out

    if [[ "$(git config --file="$path" --get homebrew.analyticsdisabled)" != "true" ]]; then
        git config --file="$path" --replace-all homebrew.analyticsdisabled true &>/dev/null
    fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

symlink() {

    # Update and/or install dotfiles. These dotfiles are stored in the dotfiles directory.
    # rcup is used to install files from the tag-specific dotfiles directory.
    # rcup is part of rcm, a management suite for dotfiles.
    # Check https://github.com/thoughtbot/rcm for more info.

    export RCRC="$dotfiles/rcrc" &&
        rcup -v -f -d "${dotfiles}"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Install Homebrew and the packages from the `Brewfile`.

    if ! command -v brew &>/dev/null; then
        install_homebrew
        opt_out_of_analytics
    fi

    if command -v brew &>/dev/null; then
        if [[ -d "$(brew --prefix)/bin" ]]; then
            export PATH="$(brew --prefix)/bin:$PATH"
        fi

        if [[ -d "$(brew --prefix)/sbin" ]]; then
            export PATH="$(brew --prefix)/sbin:$PATH"
        fi
    fi

    brew_bundle_install -f "brewfile"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # We must now symlink our dotfiles prior to executing any other function.
    # This is required because any further action will require our dotfiles
    # to be present in our $HOME directory.
    symlink

}

main

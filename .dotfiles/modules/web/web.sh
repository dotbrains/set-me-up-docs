#!/bin/bash

# shellcheck source=/dev/null

declare current_dir && \
    current_dir="$(dirname "${BASH_SOURCE[0]}")" && \
    cd "${current_dir}" && \
    source "$HOME/set-me-up/.dotfiles/utilities/utilities.sh"

LOCAL_BASH_CONFIG_FILE="${HOME}/.bash.local"
LOCAL_FISH_CONFIG_FILE="${HOME}/.fish.local"

declare -r N_DIRECTORY="$HOME/n"
declare -r NVM_DIRECTORY="$HOME/.nvm"

declare -r N_URL="https://git.io/n-install"
declare -r NVM_URL="https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# If needed, add the necessary configs in the
# local shell configuration files.
add_n_configs() {

    # bash

    declare -r BASH_CONFIGS="
# n - Node version management.
export N_PREFIX=\"\$HOME/n\";
[[ :\$PATH: == *\":\$N_PREFIX/bin:\"* ]] || PATH+=\":\$N_PREFIX/bin\"
"

    if [[ ! -e "$LOCAL_BASH_CONFIG_FILE" ]] || ! grep -q "$(<<<"$BASH_CONFIGS" tr '\n' '\01')" < <(less "$LOCAL_BASH_CONFIG_FILE" | tr '\n' '\01'); then
        printf '%s\n' "$BASH_CONFIGS" >> "$LOCAL_BASH_CONFIG_FILE" \
                && . "$LOCAL_BASH_CONFIG_FILE"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # fish

    declare -r FISH_CONFIGS="
# n - Node version management.
set -xU N_PREFIX \"\$HOME/n\"
set -U fish_user_paths \"\$N_PREFIX/bin\" \$fish_user_paths
"

    if [[ ! -e "$LOCAL_FISH_CONFIG_FILE" ]] || ! grep -q -z "$FISH_CONFIGS" "$LOCAL_BASH_CONFIG_FILE" &> /dev/null; then
        printf '%s\n' "$FISH_CONFIGS" >> "$LOCAL_FISH_CONFIG_FILE"
    fi

}

# If needed, add the necessary configs in the
# local shell configuration files.
add_nvm_configs() {

    # bash

    declare -r BASH_CONFIGS="
# nvm - Node version management.
export NVM_DIR=\"$HOME/.nvm\"
[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"  # This loads nvm
[ -s \"\$NVM_DIR/bash_completion\" ] && \. \"\$NVM_DIR/bash_completion\"  # This loads nvm bash_completion
"

    if [[ ! -e "$LOCAL_BASH_CONFIG_FILE" ]] || ! grep -q "$(<<<"$BASH_CONFIGS" tr '\n' '\01')" < <(less "$LOCAL_BASH_CONFIG_FILE" | tr '\n' '\01'); then
        printf '%s\n' "$BASH_CONFIGS" >> "$LOCAL_BASH_CONFIG_FILE" \
                && . "$LOCAL_BASH_CONFIG_FILE"
    fi

}

install_n() {

    # Install `n` and add the necessary
    # configs in the local shell config files.

    curl -sL "$N_URL" | N_PREFIX="$N_DIRECTORY" bash -s -- -q -n\
        && add_n_configs

}

install_nvm() {

    # Install `nvm` and add the necessary
    # configs in the local shell config files.

    curl -o- "$NVM_URL" | bash -s -- -q \
        && add_nvm_configs

}


update_n() {

    # Load `n`

	export N_PREFIX="$N_DIRECTORY";
	[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    n-update -y

}

update_nvm() {

	# Load `nvm` from $NVM_DIR

	export NVM_DIR="$NVM_DIRECTORY"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	(
		git -C "$NVM_DIR" fetch --tags origin && \
		git -C "$NVM_DIR" checkout \
			"$(git -C "$NVM_DIR" describe --abbrev=0 --tags --match \"v[0-9]*\" "$(git -C "$NVM_DIR" rev-list --tags --max-count=1)")" \
	) && \
		. "$NVM_DIR/nvm.sh" -q

}

install_latest_stable_node_with_n() {

    # Install the latest stable version of Node
    # (this will also set it as the default).

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `n` is installed

    if ! cmd_exists "n"; then
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	# Load `n`

	export N_PREFIX="$N_DIRECTORY";
	[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	sudo n lts

}

install_latest_stable_node_with_nvm() {

    # Install the latest stable version of Node
    # (this will also set it as the default).

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	# Load `nvm` from $NVM_DIR

	export NVM_DIR="$NVM_DIRECTORY"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	nvm install --lts

}

install_global_packages() {

	npm install --global \
		@antfu/ni # https://github.com/antfu/ni \
		opencommit # https://github.com/di-sukharev/opencommit

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    ask_for_sudo

    # if [[ ! -d "$N_DIRECTORY" ]] && ! cmd_exists "n"; then
    #     install_n
    # else
    #     update_n
    # fi

	# if [[ ! -d "$NVM_DIRECTORY" ]] && ! cmd_exists "nvm"; then
    #     install_nvm
    # else
    #     update_nvm
    # fi

    brew_bundle_install "brewfile"

    install_latest_stable_node_with_n

	# install_latest_stable_node_with_nvm

	install_global_packages

}

main

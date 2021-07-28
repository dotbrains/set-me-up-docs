function update --description "Updates your MacOS system as well as brew casks, formulae, Mac OS apps, and npm packages."
    sudo softwareupdate --install --all

    brew-update

	npm-update
end

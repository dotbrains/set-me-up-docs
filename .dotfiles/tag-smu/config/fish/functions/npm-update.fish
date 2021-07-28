function npm-update --description "Updates npm packages."
    if type -q npm
        sudo npm install npm@latest -g

        if type -q npm-check
            npm-check --global --update-all
        end
    end
end

function update --description "Updates Linux apps, brew, npm and their installed packages"
    sudo apt update
    sudo apt upgrade -y
    sudo apt dist-upgrade -y
    sudo apt full-upgrade -y
    sudo apt autoremove -y
    sudo apt clean
 
     if type -q brew
         brew update
         brew upgrade
         brew cleanup
     end
 
     if type -q npm
         sudo npm install npm@latest -g
 
         if type -q npx
             npx npm-check --global --update-all
         end
     end
 end
 